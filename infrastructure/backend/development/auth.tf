module "event_planr_auth" {
  source = "../modules/cognito"

  user_pool_name              = "${var.environment}_event_planr_pool"
  pre_token_generation_lambda = module.pre_token_generation_lambda.arn
  test_client                 = true
}

module "pre_token_generation_lambda" {
  source = "../modules/lambda-dotnet"

  function_name = "${var.environment}_pre_token_generation_function"
  handler       = "EventPlanr.PreTokenGeneration.Function::EventPlanr.PreTokenGeneration.Function.Function::FunctionHandler"
  source_dir    = "../../../backend/Serverless/EventPlanr.PreTokenGeneration.Function/bin/Release/net6.0/publish"
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = "Development"
  }
}

resource "aws_lambda_permission" "this" {
  statement_id  = "allow_execution_from_conito"
  action        = "lambda:InvokeFunction"
  function_name = module.pre_token_generation_lambda.function_name
  principal     = "cognito-idp.amazonaws.com"

  source_arn = module.event_planr_auth.user_pool_arn
}

data "aws_iam_policy_document" "user_organization_claim_table_access_policy" {
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
      aws_dynamodb_table.user_organization_claim.arn
    ]
  }
}

resource "aws_iam_role_policy" "lambda_access_to_user_organization_claim_table" {
  name   = "lambda_access_to_user_organization_claim_table"
  role   = module.pre_token_generation_lambda.role_id
  policy = data.aws_iam_policy_document.user_organization_claim_table_access_policy.json
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

resource "aws_iam_role_policy" "lambda_access_to_ssm" {
  name   = "lambda_access_to_ssm"
  role   = module.pre_token_generation_lambda.role_id
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

resource "aws_iam_role_policy" "lambda_logs" {
  name   = "lambda_logging"
  role   = module.pre_token_generation_lambda.role_id
  policy = data.aws_iam_policy_document.lambda_logging.json
}
