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

resource "aws_appsync_graphql_api" "chat_message" {
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  name                = "${var.environment}_chat_message"

  schema = file("../chat_message_graphql_schema/schema.graphql")

  user_pool_config {
    default_action = "ALLOW"
    user_pool_id   = module.event_planr_auth.user_pool_id
  }
}

resource "aws_appsync_datasource" "chat_message" {
  api_id           = aws_appsync_graphql_api.chat_message.id
  name             = "${var.environment}_chat_message"
  service_role_arn = aws_iam_role.appsync_role.arn
  type             = "AWS_LAMBDA"

  lambda_config {
    function_arn = module.chat_message_resolver_lambda.arn
  }
}

module "chat_message_resolver_lambda" {
  source = "../modules/lambda-dotnet"

  function_name = "${var.environment}_chat_message_resolver_function"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = "EventPlanr.ChatMessageResolver.Function::EventPlanr.ChatMessageResolver.Function.Function::FunctionHandler"
  source_dir    = "../../../backend/Serverless/EventPlanr.ChatMessageResolver.Function/bin/Release/net6.0/publish"
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = "Development"
  }
}

resource "aws_appsync_resolver" "chat_message_query" {
  api_id      = aws_appsync_graphql_api.chat_message.id
  type        = "Query"
  field       = "getChatMessages"
  data_source = aws_appsync_datasource.chat_message.name

  code = file("../chat_message_graphql_schema/resolver.js")

  runtime {
    name            = "APPSYNC_JS"
    runtime_version = "1.0.0"
  }
}

resource "aws_appsync_resolver" "chat_message_mutation" {
  api_id      = aws_appsync_graphql_api.chat_message.id
  type        = "Mutation"
  field       = "createMessage"
  data_source = aws_appsync_datasource.chat_message.name

  code = file("../chat_message_graphql_schema/resolver.js")

  runtime {
    name            = "APPSYNC_JS"
    runtime_version = "1.0.0"
  }
}
