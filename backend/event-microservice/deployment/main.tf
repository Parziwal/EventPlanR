data "archive_file" "lambda_archive" {
  type        = "zip"
  source_dir  = "../Event/EventGeneral.API/bin/Release/publish"
  output_path = "../Event/EventGeneral.API/bin/Release/event_general_api.zip"
}

resource "aws_lambda_function" "event_general_api" {
  filename         = data.archive_file.lambda_archive.output_path
  function_name    = "event_general_api"
  runtime          = "dotnet6"
  handler          = "EventGeneral.API"
  source_code_hash = filebase64sha256(data.archive_file.lambda_archive.output_path)
  role             = aws_iam_role.lambda_rds_access_role.arn
  timeout          = 15
  memory_size      = 1024
  environment {
    variables = {
      ConnectionStrings__EventDb = "Host=${aws_rds_cluster.event.endpoint};Port=5432;Username=event_dev;Password=event_dev;Database=event_dev"
    }
  }
}