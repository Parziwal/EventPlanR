module "lambda_apis" {
  source   = "../modules/lambda-dotnet"
  for_each = local.workspace.lambdas

  function_name = "${local.environment}_${each.key}"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = each.value
  source_dir    = replace(local.workspace.lambda_source_dir, "{LAMBDA_FOLDER}", each.value)
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = local.workspace.aspnetcore_environment
  }
}

module "pre_token_generation_lambda" {
  source = "../modules/lambda-dotnet"

  function_name = "${local.environment}_pre_token_generation_function"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = "EventPlanr.PreTokenGeneration.Function::EventPlanr.PreTokenGeneration.Function.Function::FunctionHandler"
  source_dir    = replace(local.workspace.lambda_source_dir, "{LAMBDA_FOLDER}", "EventPlanr.PreTokenGeneration.Function")
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = local.workspace.aspnetcore_environment
  }
}

module "database_initializer_lambda" {
  source = "../modules/lambda-dotnet"

  function_name = "${local.environment}_database_initializer_function"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = "EventPlanr.DatabaseInitializer.Function::EventPlanr.DatabaseInitializer.Function.Function::FunctionHandler"
  source_dir    = replace(local.workspace.lambda_source_dir, "{LAMBDA_FOLDER}", "EventPlanr.DatabaseInitializer.Function")
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = local.workspace.aspnetcore_environment
  }
}
