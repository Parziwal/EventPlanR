data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "event_rds" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    project = "event-planr"
    service = "event"
  }
}

resource "aws_internet_gateway" "event_rds" {
  vpc_id = aws_vpc.event_rds.id

  tags = {
    project = "event-planr"
    service = "event"
  }
}

resource "aws_route" "event_rds_internet_access" {
  route_table_id         = aws_vpc.event_rds.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.event_rds.id
}

resource "aws_security_group" "event_rds" {
  name        = "event-rds-security"
  description = "Allow inbound access to event RDS"
  vpc_id      = aws_vpc.event_rds.id

  ingress {
    protocol    = "tcp"
    from_port   = 5432
    to_port     = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = "event-planr"
    service = "event"
  }
}

resource "aws_subnet" "event_rds" {
  count             = 1
  cidr_block        = cidrsubnet(aws_vpc.event_rds.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.event_rds.id

  tags = {
    project = "event-planr"
    service = "event"
  }
}

resource "aws_db_subnet_group" "event_rds" {
  name       = "event-db-subnet"
  subnet_ids = aws_subnet.event_rds.*.id

  tags = {
    project = "event-planr"
    service = "event"
  }
}

resource "aws_rds_cluster" "event" {
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned"
  cluster_identifier      = "event-planr-event-cluster"
  database_name           = "event_dev"
  master_username         = "event_dev"
  master_password         = "event_dev"
  skip_final_snapshot     = true
  backup_retention_period = 1
  db_subnet_group_name    = aws_db_subnet_group.event_rds.id
  vpc_security_group_ids  = [aws_security_group.event_rds.id]

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }

  tags = {
    project = "event-planr"
    service = "event"
  }
}

resource "aws_rds_cluster_instance" "event" {
  cluster_identifier   = aws_rds_cluster.event.id
  instance_class       = "db.serverless"
  engine               = aws_rds_cluster.event.engine
  engine_version       = aws_rds_cluster.event.engine_version
  publicly_accessible  = true
  db_subnet_group_name = aws_db_subnet_group.event_rds.id

  tags = {
    project = "event-planr"
    service = "event"
  }
}
