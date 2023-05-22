output "rest_api_url" {
  description = "The rest api url."
  value       = aws_api_gateway_stage.this.invoke_url
}

output "cognito_user_pool_id" {
  description = "The cognito user pool id."
  value       = aws_cognito_user_pool.this.id
}

output "cognito_client_id" {
  description = "The cognito user pool client id."
  value       = aws_cognito_user_pool_client.this.id
}