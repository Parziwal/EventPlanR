locals {
  connection_string = "Host=${module.event_planr_db.rds_cluster_url};Port=5432;Username=master;Password=${module.event_planr_db.rds_cluster_password};Database=event_planr_db"
  lambda_source_dir = "../../../backend/Serverless/{LAMBDA_NAME}/bin/Release/net6.0/publish/dev"
}

module "event_general_api" {
  source = "../modules/lambda-dotnet"

  function_name = "${var.environment}_event_general_api"
  handler       = "EventGeneral.Api"
  source_dir    = replace(local.lambda_source_dir, "{LAMBDA_NAME}", "EventGeneral.Api")
  environment_varibles = {
    ConnectionStrings__EventPlanrDb = local.connection_string
  }
}
