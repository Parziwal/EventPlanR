data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "get_user_events_lambda_access_policy" {
  statement {
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:get_user_events"
    ]
  }
}

resource "aws_iam_role" "get_user_events_lambda_access_role" {
  name               = "get_user_events_lambda_access_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy" "rds_access_policy" {
  name   = "get_user_events_lambda_access_policy"
  role   = aws_iam_role.get_user_events_lambda_access_role.id
  policy = data.aws_iam_policy_document.get_user_events_lambda_access_policy.json
}
