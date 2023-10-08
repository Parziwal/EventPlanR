data "archive_file" "this" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = ".lambda-archive/${var.function_name}.zip"
}

resource "aws_lambda_function" "this" {
  filename                       = data.archive_file.this.output_path
  function_name                  = var.function_name
  runtime                        = "dotnet6"
  handler                        = var.handler
  source_code_hash               = filebase64sha256(data.archive_file.this.output_path)
  role                           = var.role_arn
  timeout                        = 15
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions

  environment {
    variables = var.environment_varibles
  }

  tags = var.tags
}