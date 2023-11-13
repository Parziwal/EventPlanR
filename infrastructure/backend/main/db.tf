module "event_planr_db" {
  source = "../modules/rds-aurora-postgresql"

  cluster_identifier = "${local.environment}-event-planr-cluster"
  database_name      = "event_planr_db"
  min_capacity       = 0.5
  max_capacity       = 1
}

resource "aws_dynamodb_table" "user_claim" {
  name         = "${local.environment}_UserClaim"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_dynamodb_table" "user_reserved_ticket_order" {
  name         = "${local.environment}_UserReservedTicketOrder"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_dynamodb_table" "chat_message" {
  name         = "${local.environment}_ChatMessage"
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

resource "aws_lambda_invocation" "database_initializer_lambda" {
  function_name = module.database_initializer_lambda.function_name
  input         = ""

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [module.event_planr_db]
}
