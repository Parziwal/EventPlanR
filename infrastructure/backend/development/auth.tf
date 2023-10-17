module "event_planr_auth" {
  source = "../modules/cognito"

  user_pool_name              = "${var.environment}_event_planr_pool"
  pre_token_generation_lambda = module.pre_token_generation_lambda.arn
  test_client                 = true
}

module "pre_token_generation_lambda" {
  source = "../modules/lambda-dotnet"

  function_name = "${var.environment}_pre_token_generation_function"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = "EventPlanr.PreTokenGeneration.Function::EventPlanr.PreTokenGeneration.Function.Function::FunctionHandler"
  source_dir    = "../../../backend/Serverless/EventPlanr.PreTokenGeneration.Function/bin/Release/net6.0/publish"
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = "Development"
  }
}

resource "aws_lambda_permission" "allow_execution_from_cognito" {
  statement_id  = "allow_execution_from_cognito"
  action        = "lambda:InvokeFunction"
  function_name = module.pre_token_generation_lambda.function_name
  principal     = "cognito-idp.amazonaws.com"

  source_arn = module.event_planr_auth.user_pool_arn
}

resource "aws_ssm_parameter" "cognito_user_pool_id" {
  name        = "/${var.environment}/event_planr/CognitoUserPoolOptions/UserPoolId"
  type        = "String"
  value       = module.event_planr_auth.user_pool_id
}