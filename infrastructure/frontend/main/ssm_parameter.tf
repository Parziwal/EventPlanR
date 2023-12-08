resource "aws_ssm_parameter" "frontend_bucket" {
  name  = "/${local.environment}/event_planr/frontendBucket"
  type  = "String"
  value = aws_s3_bucket.event_planr_frontend.id
}

resource "aws_ssm_parameter" "android_apk_url" {
  name  = "/${local.environment}/event_planr/androidApkUrl"
  type  = "String"
  value = "${aws_cloudfront_distribution.event_planr_frontend.domain_name}/app-production-release.apk"
}
