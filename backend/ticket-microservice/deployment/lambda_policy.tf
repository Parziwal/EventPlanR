data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ticket_tables_access_policy" {
  statement {
    actions = [
      "dynamodb:*",
    ]
    resources = [
      aws_dynamodb_table.event_ticket.arn,
      aws_dynamodb_table.sold_ticket.arn
    ]
  }
}

resource "aws_iam_role" "lambda_ticket_tables_access_role" {
  name               = "lambda_ticket_tables_access_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy" "ticket_tabless_access_policy" {
  name   = "ticket_tables_access_policy"
  role   = aws_iam_role.lambda_ticket_tables_access_role.id
  policy = data.aws_iam_policy_document.ticket_tables_access_policy.json
}