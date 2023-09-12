output "event_planr_api_url" {
  description = "Url of the event planr api"
  value       = module.event_planr_api.api_gateway_url
}

output "event_planr_db_url" {
  description = "Url of the event planr db"
  value       = module.event_planr_db.rds_cluster_url
}

output "event_planr_db_password" {
  description = "Password of the event planr db"
  value       = module.event_planr_db.rds_cluster_password
  sensitive   = true
}

output "auth_pool_id" {
  description = "Id of the cognito user pool"
  value       = module.event_planr_auth.user_pool_id
}

output "auth_pool_client_id" {
  description = "Id of the cognito user pool client"
  value       = module.event_planr_auth.user_pool_client_id
}
