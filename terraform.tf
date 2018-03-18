terraform {
  required_version = ">= 0.11.3"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "lambda_basic_execution" {
  name = "lambda_basic_execution"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "oneClick_lambda_basic_execution_policy" {
  name = "oneClick_lambda_basic_execution_policy"
  role = "${aws_iam_role.lambda_basic_execution.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        }
    ]
}
EOF
}

