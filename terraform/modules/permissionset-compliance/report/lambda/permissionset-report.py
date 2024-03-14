import boto3
import csv
import json
import string
import time
import unicodedata
import os

from datetime import datetime

s3_bucket_name = os.environ["S3_BUCKET"]
ses_sender_email = os.environ["SES_SENDER_EMAIL"]
ses_recipient_email = os.environ["SES_RECIPIENT_EMAIL"]
s3 = boto3.client('s3')
ses = boto3.client('ses')
ses_role_arn = os.environ["SES_ROLE_ARN"]

sts_client = boto3.client('sts')
assumed_role = sts_client.assume_role(
        RoleArn=ses_role_arn,
        RoleSessionName='LambdaSession'
)

ses = boto3.client('ses',
                    aws_access_key_id=assumed_role['Credentials']['AccessKeyId'],
                    aws_secret_access_key=assumed_role['Credentials']['SecretAccessKey'],
                    aws_session_token=assumed_role['Credentials']['SessionToken'])


# Variable to track if it's the first run
is_first_run = True

"""
list_accounts
"""
def list_accounts():
    account_list = []
    org = boto3.client('organizations')
    paginator = org.get_paginator('list_accounts')
    page_iterator = paginator.paginate()

    for page in page_iterator:
        for acct in page['Accounts']:
            # only add active accounts
            if acct['Status'] == 'ACTIVE':
                account_list.append({'name': acct['Name'], 'id': acct['Id']})

    return account_list

"""
list_existing_sso_instances
"""
def list_existing_sso_instances():
    client = boto3.client('sso-admin')

    sso_instance_list = []
    response = client.list_instances()
    for sso_instance in response['Instances']:
        # add only relevant keys to return
        sso_instance_list.append({'instanceArn': sso_instance["InstanceArn"], 'identityStore': sso_instance["IdentityStoreId"]})

    return sso_instance_list

"""
list_permission_sets
"""
def list_permission_sets(ssoInstanceArn):
    client = boto3.client('sso-admin')

    perm_set_dict = {}

    response = client.list_permission_sets(InstanceArn=ssoInstanceArn)

    results = response["PermissionSets"]
    while "NextToken" in response:
        response = client.list_permission_sets(InstanceArn=ssoInstanceArn, NextToken=response["NextToken"])
        results.extend(response["PermissionSets"])

    for permission_set in results:
        # get the name of the permission set from the arn
        perm_description = client.describe_permission_set(InstanceArn=ssoInstanceArn,PermissionSetArn=permission_set)
        # key: permission set name, value: permission set arn
        perm_set_dict[perm_description["PermissionSet"]["Name"]] = permission_set


    return perm_set_dict


"""
list_account_assignments
"""
def list_account_assignments(ssoInstanceArn, accountId, permissionSetArn):
    client = boto3.client('sso-admin')

    paginator = client.get_paginator("list_account_assignments")

    response_iterator = paginator.paginate(
        InstanceArn=ssoInstanceArn,
        AccountId=accountId,
        PermissionSetArn=permissionSetArn
    )

    account_assignments = []
    for response in response_iterator:
        for row in response['AccountAssignments']:
            # add only relevant keys to return
            account_assignments.append({'PrincipalType': row['PrincipalType'], 'PrincipalId': row['PrincipalId']})

    return account_assignments

"""
describe_user
"""
def describe_user(userId, identityStoreId):
    client = boto3.client('identitystore')

    response = client.describe_user(
        IdentityStoreId=identityStoreId,
        UserId=userId
    )
    username = response['UserName']

    return username

"""
describe_group
"""
def describe_group(groupId, identityStoreId):
    client = boto3.client('identitystore')
    try:
        response = client.describe_group(
            IdentityStoreId=identityStoreId,
            GroupId=groupId
        )
        groupname = response['DisplayName']
        return groupname
    except Exception as e:
        print("[WARN] Group was deleted while the report was running: " + str(groupId))
        groupname = "DELETED-GROUP"
        return groupname

"""
create_report
"""
def create_report(account_list, sso_instance, permission_sets_list, break_after=None):
    result = []

    # variables for displaying the progress of processed accounts
    length = str(len(account_list))
    i = 1

    for account in account_list:
        for permission_set in permission_sets_list.keys():
            # get all the users assigned to a permission set on the current account
            account_assignments = list_account_assignments(sso_instance['instanceArn'], account['id'], permission_sets_list[permission_set])

            # add the users and additional information to the sso report result
            for account_assignment in account_assignments:
                account_assignments_dic = {}

                # add information for all the headers
                account_assignments_dic['AccountID'] = account['id']
                account_assignments_dic['AccountName'] = account['name']
                account_assignments_dic['PermissionSet'] = permission_set
                account_assignments_dic['ObjectType'] = account_assignment['PrincipalType']

                # find human friendly name for user id if principal type is "USER"
                if account_assignments_dic['ObjectType'] == "USER":
                    username = describe_user(account_assignment['PrincipalId'], sso_instance['identityStore'])
                    account_assignments_dic['ObjectName'] = username
                # find human friendly name for group id if principal type is "GROUP"
                elif account_assignments_dic['ObjectType'] == "GROUP":
                    groupname = describe_group(account_assignment['PrincipalId'], sso_instance['identityStore'])
                    account_assignments_dic['ObjectName'] = groupname

                result.append(account_assignments_dic)

        # display the progress of processed accounts
        print(str(i) + "/" + length + " accounts done")
        i = i+1

        # debug code used for stopping after a certain amound of accounts for faster testing
        if break_after != None and i > break_after:
            break

    return result

"""
write_result_to_file
"""
def write_result_to_file(result, filename):
    global is_first_run  # Declare 'is_first_run' as a global variable
    
    # Determine the folder structure based on the date (YYYY/MM/DD)
    current_datetime = datetime.now()
    if is_first_run:
        folder_structure = "original"
        is_first_run = False  # Set it to False after the first run
    else:
        folder_structure = current_datetime.strftime("%Y/%m/%d")

    s3_key = "permissionset-compliance" + "/" + "reports" + "/" + folder_structure + "/" + filename
    
    with open("/tmp/" + filename, 'w', newline='') as csv_file:
        fieldnames = ['AccountID', 'AccountName', 'ObjectType', 'ObjectName', 'PermissionSet']
        writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

        writer.writeheader()
        for row in result:
            writer.writerow(row)
    # s3_key = "permissionset-compliance" + "/" + "reports" + "/" + filename
    s3.upload_file("/tmp/" + filename, s3_bucket_name, s3_key)
    print("Uploaded file to S3:", filename)
    


def print_time_taken(start, end):
    elapsed_time = end - start
    elapsed_time_string = str(int(elapsed_time/60)) + " minutes and "  + str(int(elapsed_time%60)) + " seconds"
    print("The report took " + elapsed_time_string + " to generate.")

def clean_filename(filename, replace=' ', char_limit=255):
    #allowed chars
    valid_filename_chars = "-_.() %s%s" % (string.ascii_letters, string.digits)

    # replace spaces
    for r in replace:
        filename = filename.replace(r,'_')

    # keep only valid ascii chars
    cleaned_filename = unicodedata.normalize('NFKD', filename).encode('ASCII', 'ignore').decode()

    # keep only whitelisted chars
    cleaned_filename = ''.join(c for c in cleaned_filename if c in valid_filename_chars)
    if len(cleaned_filename)>char_limit:
        print("Warning, filename truncated because it was over {}. Filenames may no longer be unique".format(char_limit))
    return cleaned_filename[:char_limit]
    
def send_email_with_html_body(subject, body_html):
    # Check if the sender's email address is verified
    sender_verification = ses.get_identity_verification_attributes(
        Identities=[ses_sender_email]
    )
    
    if ses_sender_email in sender_verification['VerificationAttributes'] and sender_verification['VerificationAttributes'][ses_sender_email]['VerificationStatus'] == 'Success':
        # Check if the recipient's email addresses are verified
        recipient_emails = ses_recipient_email.split(";")
        recipient_verification = ses.get_identity_verification_attributes(
            Identities=recipient_emails
        )
        
        if all(email in recipient_verification['VerificationAttributes'] and recipient_verification['VerificationAttributes'][email]['VerificationStatus'] == 'Success' for email in recipient_emails):
            response = ses.send_email(
               Source=ses_sender_email,
               Destination={
                   'ToAddresses': recipient_emails
               },
               Message={
                   'Subject': {
                       'Data': subject
                   },
                   'Body': {
                       'Html': {
                           'Data': body_html
                       }
                   }
                }
            )
            print("Email sent:", response)
        else:
            print("Recipient email addresses are not verified. Email not sent.")
    else:
        print("Sender email address is not verified. Email not sent.")
"""
lambda handler
Output:
-- CSV file: CSV with SSO report.
"""
def lambda_handler(event, context):
    start = time.time()
    account_list = list_accounts()
    sso_instance = list_existing_sso_instances()[0]
    permission_sets_list = list_permission_sets(sso_instance['instanceArn'])
    result = create_report(account_list, sso_instance, permission_sets_list)
    filename = 'sso_report_Account_Assignments_' + datetime.now().strftime("%Y-%m-%d_%H.%M.%S") + '.csv'
    filename = clean_filename(filename)
    write_result_to_file(result, filename)
    
    # Read the contents of the CSV file
    csv_contents = ''
    with open("/tmp/" + filename, 'r') as csv_file:
        csv_contents = csv_file.read()

    # Format the CSV contents as an HTML table
    csv_rows = csv_contents.split('\n')
    table_html = '<table style="border-collapse: collapse;">'
    for row in csv_rows:
        if row:
            table_html += '<tr>'
            columns = row.split(',')
            for col in columns:
                table_html += '<td style="border: 1px solid black; padding: 5px;">' + col + '</td>'
            table_html += '</tr>'
    table_html += '</table>'

    # Send an email with the HTML-formatted report in the body
    email_subject = "SSO Report " + datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    email_body = '<html><body><h2>SSO Report</h2>' + \
                 '<p>Please find below the SSO report:</p>' + \
                 table_html + \
                 '<p>The report file  is stored in the following S3 Bucket:</p>' + \
                 f'<p> S3Bucket: s3://{s3_bucket_name}</p>' + \
                 f'<p> Filename: {filename}</p>' + \
                 '</body></html>'

    send_email_with_html_body(email_subject, email_body)



    # Print the time it took to generate the report
    end = time.time()
    print_time_taken(start, end)

    return {
        'statusCode': 200,
        'body': json.dumps('SSO Report generated successfully.')
    }