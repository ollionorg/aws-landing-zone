import csv
import json
import boto3
import os
import string
import unicodedata

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


def write_result_to_file(data, filename):      
    current_datetime = datetime.now()
    folder_structure = current_datetime.strftime("%Y/%m/%d")
    s3_key = "permissionset-compliance" + "/" + "validation" + "/" + folder_structure + "/" + filename
    
    with open("/tmp/" + filename, 'w', newline='') as file:
        json.dump(data, file)
       

    s3.upload_file("/tmp/" + filename, s3_bucket_name, s3_key)
    print("Uploaded file to S3:", filename)


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



def lambda_handler(event, context):
    # Parse the JSON event data
    # event_data = json.loads(event['Records'][0]['Sns']['Message'])
    data = event
    filename = 'permissionset_validation_alert' + datetime.now().strftime("%Y-%m-%d_%H.%M.%S") + '.txt'
    filename = clean_filename(filename)
    
    attachment_path = f'/tmp/{filename}'
    write_result_to_file(data, filename)
    
    # Extract relevant fields
    event_fields = {
        "eventTime": data['detail']['eventTime'],
        "eventSource": data['detail']['eventSource'],
        "eventName": data['detail']['eventName'],
        "awsRegion": data['detail']['awsRegion'],
        "sourceIPAddress": data['detail']['sourceIPAddress'],
        "userAgent": data['detail']['userAgent'],
        "instanceArn": data['detail']['requestParameters']['instanceArn'],
    }

    request_fields = {
        "targetId": data['detail']['requestParameters']['targetId'],
        "targetType": data['detail']['requestParameters']['targetType'],
        "permissionSetArn": data['detail']['requestParameters']['permissionSetArn'],
        "principalType": data['detail']['requestParameters']['principalType'],
        "principalId": data['detail']['requestParameters']['principalId'],
    }

    # Generate an HTML table
    html_table = generate_html_table(event_fields, request_fields)

    # Send the HTML content in an email using SES
    send_email(html_table, attachment_path, filename)

def generate_html_table(event_fields, request_fields):
    html_table = """<html><body><table border="1">
    <tr><th>Field</th><th>Value</th></tr>"""

    # Add event fields to the HTML table
    for key, value in event_fields.items():
        html_table += f"<tr><td>{key}</td><td>{value}</td></tr>"

    # Add an empty row for spacing
    html_table += "<tr><td>&nbsp;</td><td>&nbsp;</td></tr>"

    # Add request fields to the HTML table
    for key, value in request_fields.items():
        html_table += f"<tr><td>{key}</td><td>{value}</td></tr>"

    html_table += "</table></body></html>"
    return html_table


def send_email(html_content, attachment_path, filename):
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
            from email.mime.multipart import MIMEMultipart
            from email.mime.text import MIMEText
            from email.mime.application import MIMEApplication

            sender_email = ses_sender_email
            recipient_emails = ses_recipient_email.split(";")
            # recipient_email = ses_recipient_email

            subject = 'AWS Event Data'

            msg = MIMEMultipart()
            msg['Subject'] = subject
            msg['From'] = sender_email
            msg['To'] = ", ".join(recipient_emails)

            # Attach HTML content
            msg.attach(MIMEText(html_content, 'html'))

            # Attach the text file with the specified filename as an attachment
            with open(attachment_path, 'rb') as file:
                attachment_data = file.read()

            attachment = MIMEApplication(attachment_data)
            attachment.add_header('Content-Disposition', 'attachment', filename=filename)
            msg.attach(attachment)

            # Send the email with SES
            ses.send_raw_email(
                Source=sender_email,
                RawMessage={
                    'Data': msg.as_string()
                }
            )
            print("Email sent")
        else:
            print("Recipient email addresses are not verified. Email not sent.")
    else:
        print("Sender email address is not verified. Email not sent.")