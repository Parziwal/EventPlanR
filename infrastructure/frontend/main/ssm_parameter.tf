resource "aws_ssm_parameter" "frontend_bucket" {
  name  = "/${local.environment}/event_planr/frontendBucket"
  type  = "String"
  value = aws_s3_bucket.event_planr_frontend.id
}
