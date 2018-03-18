terraform {
  required_version = ">= 0.11.3"
}

provider "aws" {
  region = "us-east-1"
}

variable "lambda_function_dir" {
  type = "string"
  default = "myColorSkill"
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

data "archive_file" "lambda_zip" {
    type        = "zip"
    source_dir  = "${var.lambda_function_dir}"
    output_path = "${var.lambda_function_dir}.zip"
}

resource "aws_lambda_function" "myColorSkill" {
  filename = "${var.lambda_function_dir}.zip"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  function_name = "myColorSkill"
  role = "${aws_iam_role.lambda_basic_execution.arn}"
  description = "My Color Skill Lambda Function"
  handler = "lambda_function.lambda_handler"
  runtime = "python2.7"
}

output "lambda_function_arn" {
  value = "${aws_lambda_function.myColorSkill.arn}"
}
