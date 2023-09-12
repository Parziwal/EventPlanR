output "rds_cluster_url" {
  description = "The url of the rds cluster"
  value       = aws_rds_cluster.this.endpoint
}

output "rds_cluster_password" {
  description = "Password of the rds cluster"
  value       = aws_secretsmanager_secret_version.this.secret_string
}
