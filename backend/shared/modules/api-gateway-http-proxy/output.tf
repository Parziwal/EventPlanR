output "api_gateway_url" {
  description = "The API Gateway URL"
  value       = aws_apigatewayv2_api.this.api_endpoint
}
