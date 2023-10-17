locals {
  lambda_source_dir      = "../../../backend/Serverless/{LAMBDA_FOLDER}/bin/Release/net6.0/publish"
  aspnetcore_environmnet = "Development"
  lambdas = {
    event_general_api = "EventPlanr.EventGeneral.Api",
    event_manager_api = "EventPlanr.EventManager.Api",
    organization_manager_api = "EventPlanr.OrganizationManager.Api",
    ticket_manager_api = "EventPlanr.TicketManager.Api",
    ticket_order_api = "EventPlanr.TicketOrder.Api",
    user_ticket_api = "EventPlanr.UserTicket.Api"
  }
}

module "lambda_apis" {
  source   = "../modules/lambda-dotnet"
  for_each = local.lambdas

  function_name = "${var.environment}_${each.key}"
  role_arn      = aws_iam_role.lambda_role.arn
  handler       = each.value
  source_dir    = replace(local.lambda_source_dir, "{LAMBDA_FOLDER}", each.value)
  environment_varibles = {
    ASPNETCORE_ENVIRONMENT = local.aspnetcore_environmnet
  }
}
