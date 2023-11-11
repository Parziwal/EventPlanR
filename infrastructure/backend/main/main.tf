module "event_planr_api" {
  source = "../modules/api-gateway-http-proxy"

  api_name               = "${local.environment}_event_planer_api"
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
    },
    "/newspost" = {
      lambda_invoke_arn = module.lambda_apis["news_post_api"].invoke_arn,
      use_authorization = true
    },
    "/chatmanager" = {
      lambda_invoke_arn = module.lambda_apis["chat_manager_api"].invoke_arn,
      use_authorization = true
    }
  }
}
