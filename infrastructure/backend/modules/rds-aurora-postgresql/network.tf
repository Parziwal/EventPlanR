resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = var.tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route" "this" {
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_security_group" "this" {
  name        = "AllowPostgresql"
  description = "Allow inbound access to the postgresql RDS"
  vpc_id      = aws_vpc.this.id

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

  tags = var.tags
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "this" {
  count             = var.subnet_count
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.this.id

  tags = var.tags
}

resource "aws_db_subnet_group" "this" {
  name       = "main"
  subnet_ids = aws_subnet.this.*.id

  tags = var.tags
}
