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
    "/eventgeneral" = {
      lambda_invoke_arn = module.lambda_apis["event_general_api"].invoke_arn,
      use_authorization = false
    },
    "/eventmanager" = {
      lambda_invoke_arn = module.lambda_apis["event_manager_api"].invoke_arn,
      use_authorization = true
    },
    "/organizationmanager" = {
      lambda_invoke_arn = module.lambda_apis["organization_manager_api"].invoke_arn,
      use_authorization = true
    },
    "/ticketmanager" = {
      lambda_invoke_arn = module.lambda_apis["ticket_manager_api"].invoke_arn,
      use_authorization = true
    },
    "/ticketorder" = {
      lambda_invoke_arn = module.lambda_apis["ticket_order_api"].invoke_arn,
      use_authorization = true
    },
    "/userticket" = {
      lambda_invoke_arn = module.lambda_apis["user_ticket_api"].invoke_arn,
      use_authorization = true
    }
  }
}

module "event_planr_auth" {
  source = "../modules/cognito"

  user_pool_name = "${var.environment}_event_planr_pool"
}
