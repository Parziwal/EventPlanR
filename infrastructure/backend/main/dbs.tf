module "event_planr_db" {
  source = "../modules/rds-aurora-postgresql"

  cluster_identifier = "${local.environment}-event-planr-cluster"
  database_name      = "event_planr_db"
  min_capacity       = 0.5
  max_capacity       = 1
}

resource "aws_dynamodb_table" "user_claim" {
  name         = "UserClaim"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_dynamodb_table" "user_reserved_ticket_order" {
  name         = "UserReservedTicketOrder"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_dynamodb_table" "chat_message" {
  name         = "ChatMessage"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ChatId"
  range_key    = "CreatedAt"

  attribute {
    name = "ChatId"
    type = "S"
  }

  attribute {
    name = "CreatedAt"
    type = "S"
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

resource "aws_lambda_invocation" "database_initializer_lambda" {
  function_name = module.database_initializer_lambda.function_name
  input         = ""

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [ module.event_planr_db ]
}

resource "aws_ssm_parameter" "event_planr_db" {
  name  = "/${local.environment}/event_planr/ConnectionStrings/EventPlanrDb"
  type  = "SecureString"
  value = "Host=${module.event_planr_db.cluster_url};Port=5432;Username=${module.event_planr_db.username};Password=${module.event_planr_db.password};Database=${module.event_planr_db.database_name}"
}

resource "aws_ssm_parameter" "user_claim" {
  name  = "/${local.environment}/event_planr/DynamoDbTableOptions/UserClaimTable"
  type  = "String"
  value = aws_dynamodb_table.user_claim.name
}

resource "aws_ssm_parameter" "user_reserved_ticket_order" {
  name  = "/${local.environment}/event_planr/DynamoDbTableOptions/UserReservedTicketOrderTable"
  type  = "String"
  value = aws_dynamodb_table.user_reserved_ticket_order.name
}

resource "aws_ssm_parameter" "chat_message" {
  name  = "/${local.environment}/event_planr/DynamoDbTableOptions/ChatMessageTable"
  type  = "String"
  value = aws_dynamodb_table.chat_message.name
}
