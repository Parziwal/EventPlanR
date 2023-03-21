output "api_url" {
  description = "The api URL."
  value       = aws_apigatewayv2_api.this.api_endpoint
}

output "api_id" {
  description = "The api id."
  value       = aws_apigatewayv2_api.this.id
}