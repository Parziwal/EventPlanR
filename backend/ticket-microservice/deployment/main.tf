data "archive_file" "event_ticket_api" {
  type        = "zip"
  source_dir  = "../Ticket/EventTicket/bin/Release/publish"
  output_path = "../Ticket/EventTicket/bin/Release/event_ticket_api.zip"
}

data "archive_file" "get_user_events" {
  type        = "zip"
  source_dir  = "../Ticket/GetUserEvents/bin/Release/publish"
  output_path = "../Ticket/GetUserEvents/bin/Release/get_user_events.zip"
}

resource "aws_lambda_function" "event_ticket_api" {
  filename         = data.archive_file.event_ticket_api.output_path
  function_name    = "event_ticket_api"
  runtime          = "dotnet6"
  handler          = "EventTicket.API"
  source_code_hash = filebase64sha256(data.archive_file.event_ticket_api.output_path)
  role             = aws_iam_role.lambda_ticket_tables_access_role.arn
  timeout          = 15
  memory_size      = 1024
}

resource "aws_lambda_function" "get_user_events" {
  filename         = data.archive_file.get_user_events.output_path
  function_name    = "get_user_events"
  runtime          = "dotnet6"
  handler          = "GetUserEvents::GetUserEvents.Function::FunctionHandler"
  source_code_hash = filebase64sha256(data.archive_file.get_user_events.output_path)
  role             = aws_iam_role.lambda_ticket_tables_access_role.arn
  timeout          = 15
  memory_size      = 1024
}