output "event_db_url" {
  description = "The event databse url."
  value       = aws_rds_cluster.event.endpoint
}

output "event_db_username" {
  description = "The event databse master username."
  value       = aws_rds_cluster.event.master_username
}

output "event_db_password" {
  description = "The event databse master password."
  value       = nonsensitive(aws_rds_cluster.event.master_password)
}