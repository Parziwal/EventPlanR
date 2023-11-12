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

data "aws_iam_policy_document" "chat_message_table_access" {
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
      aws_dynamodb_table.chat_message.arn
    ]
  }
}

data "aws_iam_policy_document" "read_parameter_store" {
  statement {
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParametersByPath",
    ]
    resources = [
      "arn:aws:ssm:${local.workspace.region}:${data.aws_caller_identity.default.account_id}:parameter/${local.environment}/event_planr*"
    ]
  }
}

data "aws_iam_policy_document" "logging" {
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

data "aws_iam_policy_document" "cognito_list_users_access" {
  statement {
    actions = [
      "cognito-idp:ListUsers",
      "cognito-idp:AdminUpdateUserAttributes",
    ]
    resources = [
      module.event_planr_auth.user_pool_arn
    ]
  }
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

data "aws_iam_policy_document" "event_planr_images_bucket_access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      "${aws_s3_bucket.event_planr_images.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "user_claim_table_access" {
  name   = "user_claim_table_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.user_claim_table_access.json
}

resource "aws_iam_role_policy" "user_reserved_ticket_order_table_access" {
  name   = "user_reserved_ticket_order_table_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.user_reserved_ticket_order_table_access.json
}

resource "aws_iam_role_policy" "chat_message_table_access" {
  name   = "chat_message_table_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.chat_message_table_access.json
}

resource "aws_iam_role_policy" "read_parameter_store" {
  name   = "read_parameter_store"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.read_parameter_store.json
}

resource "aws_iam_role_policy" "logging" {
  name   = "logging"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.logging.json
}

resource "aws_iam_role_policy" "cognito_list_users_access" {
  name   = "cognito_list_users_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.cognito_list_users_access.json
}

resource "aws_iam_role_policy" "reserved_ticket_order_expiration_queue_access" {
  name   = "reserved_ticket_order_expiration_queue_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.reserved_ticket_order_expiration_queue_access.json
}

resource "aws_iam_role_policy" "event_planr_images_bucket_access" {
  name   = "event_planr_images_bucket_access"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.event_planr_images_bucket_access.json
}
