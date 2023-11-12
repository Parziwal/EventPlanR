module "lambda_apis" {
  source   = "../modules/lambda-dotnet"
  for_each = local.workspace.lambdas

  function_name = "${local.environment}_${each.key}"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = each.value
  source_dir    = replace(local.workspace.lambda_source_dir, "{LAMBDA_FOLDER}", each.value)
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = local.workspace.aspnetcore_environmnet
  }
}

module "pre_token_generation_lambda" {
  source = "../modules/lambda-dotnet"

  function_name = "${local.environment}_pre_token_generation_function"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = "EventPlanr.PreTokenGeneration.Function::EventPlanr.PreTokenGeneration.Function.Function::FunctionHandler"
  source_dir    = "../../../backend/Serverless/EventPlanr.PreTokenGeneration.Function/bin/Release/net6.0/publish"
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = "Development"
  }
}

module "database_initializer_lambda" {
  source = "../modules/lambda-dotnet"

  function_name = "${local.environment}_database_initializer_function"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = "EventPlanr.DatabaseInitializer.Function::EventPlanr.DatabaseInitializer.Function.Function::FunctionHandler"
  source_dir    = "../../../backend/Serverless/EventPlanr.DatabaseInitializer.Function/bin/Release/net6.0/publish"
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = "Development"
  }
}