module "event_planr_db" {
  source = "../modules/rds-aurora-postgresql"

  cluster_identifier = "${var.environment}-event-planr-cluster"
  database_name      = "event_planr_db"
  min_capacity       = 0.5
  max_capacity       = 0.5
}

module "event_planr_api" {
  source = "../modules/api-gateway-http-proxy"

  api_name               = "${var.environment}_event_planer_api"
  cognito_pool_id        = module.event_planr_auth.user_pool_id
  cognito_pool_client_id = module.event_planr_auth.user_pool_client_id

  route_settings = {
    "/general" = {
      lambda_invoke_arn = module.event_general_api.invoke_arn,
      use_authorization = false
    }
  }
}

module "event_planr_auth" {
  source = "../modules/cognito"

  user_pool_name = "${var.environment}_event_planr_pool"
}
