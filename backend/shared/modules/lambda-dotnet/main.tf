data "archive_file" "this" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = ".lambda-archive/${var.function_name}.zip"
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.this.output_path
  function_name    = var.function_name
  runtime          = "dotnet6"
  handler          = var.handler
  source_code_hash = filebase64sha256(data.archive_file.this.output_path)
  role             = aws_iam_role.this.arn
  timeout          = 15
  memory_size      = 1024

  environment {
    variables = var.environment_varibles
  }

  tags = var.tags
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.function_name}LambdaRole"
  assume_role_policy = data.aws_iam_policy_document.this.json

  tags = var.tags
}
