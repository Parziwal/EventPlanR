data "archive_file" "lambda_archive" {
  type        = "zip"
  source_dir  = "../Message/GetUsers/bin/Release/publish"
  output_path = "../Message/GetUsers/bin/Release/get_users.zip"
}

resource "aws_lambda_function" "get_users" {
  filename         = data.archive_file.lambda_archive.output_path
  function_name    = "get_users"
  runtime          = "dotnet6"
  handler          = "GetUsers::GetUsers.Functions::Get"
  source_code_hash = filebase64sha256(data.archive_file.lambda_archive.output_path)
  role             = aws_iam_role.lambda_cognito_access_role.arn
  timeout          = 15
  memory_size      = 1024
}
