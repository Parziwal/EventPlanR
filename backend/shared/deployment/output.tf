output "rest_api_url" {
  description = "The rest api url."
  value       = aws_api_gateway_stage.this.invoke_url
}