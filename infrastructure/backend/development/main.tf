module "event_planr_api" {
  source = "../modules/api-gateway-http-proxy"

  api_name               = "${var.environment}_event_planer_api"
  cognito_pool_id        = module.event_planr_auth.user_pool_id
  cognito_pool_client_id = module.event_planr_auth.user_pool_client_id

  route_settings = {
    "/organizationmanager" = {
      lambda_invoke_arn = module.lambda_apis["organization_manager_api"].invoke_arn,
      use_authorization = true
    }
  }
}
