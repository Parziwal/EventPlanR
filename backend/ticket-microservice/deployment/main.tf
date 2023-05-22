data "archive_file" "lambda_archive" {
  type        = "zip"
  source_dir  = "../Ticket/EventTicket/bin/Release/publish"
  output_path = "../Ticket/EventTicket/bin/Release/event_ticket_api.zip"
}

resource "aws_lambda_function" "event_ticket_api" {
  filename         = data.archive_file.lambda_archive.output_path
  function_name    = "event_ticket_api"
  runtime          = "dotnet6"
  handler          = "EventTicket.API"
  source_code_hash = filebase64sha256(data.archive_file.lambda_archive.output_path)
  role             = aws_iam_role.lambda_ticket_tables_access_role.arn
  timeout          = 15
  memory_size      = 1024
}