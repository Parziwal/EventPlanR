output "appsync_url" {
  description = "The appsync url."
  value       = aws_appsync_graphql_api.this.uris
}

output "appsync_api_key" {
  description = "The appsync api key."
  value       = nonsensitive(aws_appsync_api_key.this.key)
}
