data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "event_planr_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "user_claim_table_access" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
    ]
    resources = [
      aws_dynamodb_table.user_claim.arn
    ]
  }
}

resource "aws_iam_role_policy" "user_claim_table_access" {
  name   = "user_claim_table_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.user_claim_table_access.json
}

data "aws_caller_identity" "default" {}

data "aws_iam_policy_document" "read_parameter_store" {
  statement {
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParametersByPath",
    ]
    resources = [
      "arn:aws:ssm:${var.region}:${data.aws_caller_identity.default.account_id}:parameter/${var.environment}/event_planr*"
    ]
  }
}

resource "aws_iam_role_policy" "read_parameter_store" {
  name   = "read_parameter_store"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.read_parameter_store.json
}

data "aws_iam_policy_document" "lambda_logging" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_role_policy" "lambda_logging" {
  name   = "lambda_logging"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_logging.json
}

data "aws_iam_policy_document" "cognito_list_users_access" {
  statement {
    actions = [
      "cognito-idp:ListUsers"
    ]
    resources = [
      module.event_planr_auth.user_pool_arn
    ]
  }
}

resource "aws_iam_role_policy" "cognito_list_users_access" {
  name   = "cognito_list_users_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.cognito_list_users_access.json
}

data "aws_iam_policy_document" "user_reserved_ticket_order_table_access" {
  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
    ]
    resources = [
      aws_dynamodb_table.user_reserved_ticket_order.arn
    ]
  }
}

resource "aws_iam_role_policy" "user_reserved_ticket_order_table_access" {
  name   = "user_reserved_ticket_order_table_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.user_reserved_ticket_order_table_access.json
}

data "aws_iam_policy_document" "reserved_ticket_order_expiration_queue_access" {
  statement {
    actions = [
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:SendMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:SetQueueAttributes"
    ]
    resources = [
      aws_sqs_queue.reserved_ticket_order_expiration_queue.arn
    ]
  }
}

resource "aws_iam_role_policy" "reserved_ticket_order_expiration_queue_access" {
  name   = "reserved_ticket_order_expiration_queue_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.reserved_ticket_order_expiration_queue_access.json
}
