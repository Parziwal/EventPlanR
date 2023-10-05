module "event_planr_db" {
  source = "../modules/rds-aurora-postgresql"

  cluster_identifier = "${var.environment}-event-planr-cluster"
  database_name      = "event_planr_db"
  min_capacity       = 0.5
  max_capacity       = 1
}

resource "aws_dynamodb_table" "user_organization_claim" {
  name           = "UserOrganizationClaim"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_ssm_parameter" "event_planr_db" {
  name        = "/${var.environment}/event_planr/ConnectionStrings/EventPlanrDb"
  type        = "SecureString"
  value       = "Host=${module.event_planr_db.cluster_url};Port=5432;Username=${module.event_planr_db.username};Password=${module.event_planr_db.password};Database=${module.event_planr_db.database_name}"
}

resource "aws_ssm_parameter" "user_organization_claim" {
  name        = "/${var.environment}/event_planr/DynamoDbTableOptions/UserOrganizationClaimTable"
  type        = "String"
  value       = aws_dynamodb_table.user_organization_claim.name
}