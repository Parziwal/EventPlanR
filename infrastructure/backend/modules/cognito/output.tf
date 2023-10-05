output "user_pool_id" {
  description = "Id of the cognito user pool"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_client_id" {
  description = "Id of the cognito user pool client"
  value       = aws_cognito_user_pool_client.mobile.id
}

output "user_pool_arn" {
  description = "Arn of the cognito user pool"
  value       = aws_cognito_user_pool.this.arn
}
