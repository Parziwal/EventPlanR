data "aws_cognito_user_pools" "this" {
  name = "event_planr_user_pool"
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "cognito_access_policy" {
  statement {
    actions = [
      "cognito-idp:ListUsers"
    ]
    resources = [
      tolist(data.aws_cognito_user_pools.this.arns)[0]
    ]
  }
}

resource "aws_iam_role" "lambda_cognito_access_role" {
  name               = "lambda_cognito_access_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy" "cognito_access_policy" {
  name   = "cognito_access_policy"
  role   = aws_iam_role.lambda_cognito_access_role.id
  policy = data.aws_iam_policy_document.cognito_access_policy.json
}
