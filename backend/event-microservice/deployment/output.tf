output "event_db_url" {
  description = "Url of the event databse"
  value       = module.event_db.rds_cluster_url
}
output "event_api_url" {
  description = "Url of the event Api"
  value       = module.event_api.api_gateway_url
}
