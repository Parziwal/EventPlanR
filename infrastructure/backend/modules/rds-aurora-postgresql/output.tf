output "cluster_url" {
  description = "Url of the rds cluster"
  value       = aws_rds_cluster.this.endpoint
}

output "username" {
  description = "Username of the rds cluster"
  value       = aws_rds_cluster.this.master_username
}


output "password" {
  description = "Password of the rds cluster"
  value       = aws_rds_cluster.this.master_password
}

output "database_name" {
  description = "Name of the RDS database"
  value       = aws_rds_cluster.this.database_name
}
