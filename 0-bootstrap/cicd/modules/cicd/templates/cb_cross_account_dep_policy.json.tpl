{
  "Version": "2012-10-17",
  "Statement": [
%{ for v in roles }
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "${v}"
    },
%{ endfor }
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:codebuild:us-east-1:${account_id}:report-group/*"
      ],
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:BatchPutTestCases",
        "codebuild:UpdateReport"
      ]
    },
%{ if priv_vpc_id != "" }
    {
      "Effect": "Allow", 
      "Action": [
        "ec2:*"
      ],
      "Resource": "*" 
    },
%{ endif }
    {
      "Effect": "Allow",
      "Resource": [
        "${codebuild_logs_bucket}",
        "${codebuild_logs_bucket}/*",
        "${codepipeline_artifact_bucket}",
        "${codepipeline_artifact_bucket}/*"
      ],
      "Action": [
        "s3:*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codestar-connections:UseConnection"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Resource": "${codebuild_kms_key}",
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:GenerateDataKey*",
        "kms:ReEncrypt*"
      ]
    }
  ]
}
