output "api_gateway_url" {
  description = "The api gateway url"
  value       = aws_apigatewayv2_api.this.api_endpoint
}
