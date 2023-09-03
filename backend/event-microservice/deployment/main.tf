module "event_general_api" {
  source = "../../shared/modules/lambda-dotnet"

  function_name = "${var.environment}_EventGeneralApi"
  handler       = "EventGeneral.API"
  source_dir    = var.event_general_api_source_dir
  environment_varibles = {
    ConnectionStrings__EventDb = "Host=${module.event_db.rds_cluster_url};Port=5432;Username=master;Password=${module.event_db.rds_cluster_password};Database=EventDb"
    LambdaFunctionOptions__GetUserEventsFunctionName  = var.get_user_events_function_name
  }

  tags = var.tags
}

module "event_api" {
  source = "../../shared/modules/api-gateway-http-proxy"

  api_name = "${var.environment}_EventApi"
  route_settings = {
    "/general" = {
      lambda_invoke_arn = module.event_general_api.invoke_arn,
      use_authorization = false
    }
  }
}

module "event_db" {
  count = 0
  source = "../../shared/modules/rds-aurora-postgresql"

  cluster_identifier = "${var.environment}-event-cluster"
  database_name      = "EventDb"
  min_capacity       = 0.5
  max_capacity       = 1

  tags = var.tags
}
