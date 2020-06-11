terraform {
  backend "local" {}
}

provider "aws" {
  # access_key                  = "mock_access_key"
  region                      = "us-west-2"
  # s3_force_path_style         = true
  # secret_key                  = "mock_secret_key"
  # skip_credentials_validation = true
  # skip_metadata_api_check     = true
  # skip_requesting_account_id  = true

  # endpoints {
  #  s3            = "http://localhost:4572"
  #  lambda        = "http://localhost:4574"
  #  iam           = "http://localhost:4593"
  #  stepfunctions = "http://localhost:4585"
  # }
}



resource "aws_iam_role" "iam_for_sfn" {
  name = "proof-of-concept-state-machine"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "states.us-west-2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "proof-of-concept-lambda"
  
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

resource "aws_iam_role_policy" "step_function_lambda_invoker" {
  role = aws_iam_role.iam_for_sfn.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Effect": "Allow",
      "Resource": "${aws_lambda_function.greeting_task.arn}"
    },
    {
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Effect": "Allow",
      "Resource": "${aws_lambda_function.salutations_task.arn}"
    }
  ]
}
EOF
}



resource "aws_lambda_function" "greeting_task" {
  function_name = "Greetings"
  handler = "StepFunctionsProofOfConcept::StepFunctionsProofOfConcept.StepFunctionTasks::Greeting"
  role = aws_iam_role.iam_for_lambda.arn
  runtime = "dotnetcore3.1"
  filename = "../release/latest.zip"
  source_code_hash = filebase64sha512("../release/latest.zip")
  memory_size = 128
  publish = true
}

resource "aws_lambda_function" "salutations_task" {
  function_name = "Salutations"
  handler = "StepFunctionsProofOfConcept::StepFunctionsProofOfConcept.StepFunctionTasks::Salutations"
  role = aws_iam_role.iam_for_lambda.arn
  runtime = "dotnetcore3.1"
  filename = "../release/latest.zip"
  source_code_hash = filebase64sha512("../release/latest.zip")
  memory_size = 128
  publish = true
  
}

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "proof-of-concept-state-machine"
  role_arn = aws_iam_role.iam_for_sfn.arn
  
  

  definition = <<EOF
{
  "Comment": "State Machine",
  "StartAt": "Greeting",
  "States": {
    "Greeting": {
      "Type": "Task",
      "Resource": "${aws_lambda_function.greeting_task.arn}",
      "Next": "WaitToActivate"
    },
    "WaitToActivate": {
      "Type": "Wait",
      "SecondsPath": "$.WaitInSeconds",
      "Next": "Salutations"
    },
    "Salutations": {
      "Type": "Task",
      "Resource": "${aws_lambda_function.salutations_task.arn}",
      "End": true
    }
  }
}
EOF
}