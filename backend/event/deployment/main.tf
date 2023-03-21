resource "aws_dynamodb_table" "events" {
  name           = "events"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
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

data "aws_iam_policy_document" "event_table_access_policy" {
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
      aws_dynamodb_table.events.arn,
    ]
  }
}

resource "aws_iam_role" "lambda_access_events_table" {
  name               = "lambda_access_to_event_table"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy" "lambda_access_to_events_table" {
  name   = "lambda_access_to_shopping_list_tables_policy"
  role   = aws_iam_role.lambda_access_events_table.id
  policy = data.aws_iam_policy_document.event_table_access_policy.json
}

data "archive_file" "lambda_archive" {
  type        = "zip"
  source_dir  = "../EventLambda/bin/Release/net7.0/win-x64/publish"
  output_path = "../EventLambda/bin/Release/net7.0/win-x64/event_lambda.zip"
}

resource "aws_lambda_function" "function" {
  filename         = data.archive_file.lambda_archive.output_path
  function_name    = "event_lambda"
  runtime          = "dotnet6"
  handler          = "EventLambda"
  source_code_hash = filebase64sha256(data.archive_file.lambda_archive.output_path)
  role             = aws_iam_role.lambda_access_events_table.arn
}

data "aws_apigatewayv2_api" "this" {
  api_id = "dpkiq3jn4a"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id = data.aws_apigatewayv2_api.this.api_id

  integration_uri    = aws_lambda_function.function.arn
  integration_type   = "AWS_PROXY"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "get_product_route" {
  api_id = data.aws_apigatewayv2_api.this.api_id

  route_key = "ANY /event"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_lambda_permission" "get_lambda_api_gw" {
  statement_id  = "AllowLambdaExecutionFromAPIGateway_${aws_lambda_function.function.function_name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${data.aws_apigatewayv2_api.this.arn}/*/*"
}