data "aws_iam_policy_document" "appsync_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["appsync.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "appsync_role" {
  name               = "appsync_role"
  assume_role_policy = data.aws_iam_policy_document.appsync_assume_role.json
}

data "aws_iam_policy_document" "chat_message_resolver_lambda_access" {
  statement {
    actions = [
      "lambda:InvokeFunction",
    ]
    resources = [
      module.chat_message_resolver_lambda.arn
    ]
  }
}

resource "aws_iam_role_policy" "chat_message_resolver_lambda_access" {
  name   = "chat_message_resolver_lambda_access"
  role   = aws_iam_role.appsync_role.id
  policy = data.aws_iam_policy_document.chat_message_resolver_lambda_access.json
}
