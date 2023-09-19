output "function_name" {
  description = "The name of the lambda function"
  value       = aws_lambda_function.this.function_name
}

output "invoke_arn" {
  description = "The invoke arn of the lambda function"
  value       = aws_lambda_function.this.invoke_arn
}

output "role_id" {
  description = "The role id of the lambda function"
  value       = aws_iam_role.this.id
}