module "reserved_ticket_order_expiration" {
  source = "../modules/lambda-dotnet"

  function_name = "${local.environment}_reserved_ticket_order_expiration_function"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = "EventPlanr.ReservedTicketOrderExpiration.Function::EventPlanr.ReservedTicketOrderExpiration.Function.Function::FunctionHandler"
  source_dir    = "../../../backend/Serverless/EventPlanr.ReservedTicketOrderExpiration.Function/bin/Release/net6.0/publish"
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = "Development"
  }
}

resource "aws_sqs_queue" "reserved_ticket_order_expiration_queue" {
  name                      = "reserved_ticket_order_expiration_queue"
  message_retention_seconds = 1200
  receive_wait_time_seconds = 10
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = aws_sqs_queue.reserved_ticket_order_expiration_queue.arn
  function_name    = module.reserved_ticket_order_expiration.arn
  enabled          = true
  batch_size       = 1
}

resource "aws_ssm_parameter" "reserved_ticket_order_expiration_queue" {
  name  = "/${local.environment}/event_planr/SqsQueueOptions/ReservedTicketOrderExpirationQueueName"
  type  = "String"
  value = aws_sqs_queue.reserved_ticket_order_expiration_queue.name
}