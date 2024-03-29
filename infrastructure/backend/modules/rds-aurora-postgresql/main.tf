resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_rds_cluster" "this" {
  engine                 = "aurora-postgresql"
  engine_mode            = "provisioned"
  cluster_identifier     = var.cluster_identifier
  database_name          = var.database_name
  master_username        = "master"
  master_password        = random_password.this.result
  db_subnet_group_name   = aws_db_subnet_group.this.id
  vpc_security_group_ids = [aws_security_group.this.id]
  skip_final_snapshot    = true
  apply_immediately      = true

  serverlessv2_scaling_configuration {
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }

  tags = var.tags
}

resource "aws_rds_cluster_instance" "this" {
  count = var.db_instance_count

  cluster_identifier   = aws_rds_cluster.this.id
  instance_class       = "db.serverless"
  engine               = aws_rds_cluster.this.engine
  engine_version       = aws_rds_cluster.this.engine_version
  publicly_accessible  = true
  db_subnet_group_name = aws_db_subnet_group.this.id

  tags = var.tags
}
