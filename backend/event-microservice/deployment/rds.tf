data "aws_availability_zones" "available" {
}

resource "aws_rds_cluster" "cluster" {
  engine               = "aurora-postgresql"
  engine_mode          = "serverless"
  cluster_identifier   = "event-planr-event-cluster"
  database_name        = "event_dev"
  master_username      = "event_dev"
  master_password      = "event_dev"
  availability_zones   = [data.aws_availability_zones.available.names[0]]
  skip_final_snapshot  = true
  apply_immediately = true

  scaling_configuration {
    auto_pause               = true
    seconds_until_auto_pause = 300
    max_capacity             = 2
    min_capacity             = 2
  }
}
