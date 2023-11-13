module "event_planr_auth" {
  source = "../modules/cognito"

  user_pool_name              = "${local.environment}_event_planr_pool"
  pre_token_generation_lambda = module.pre_token_generation_lambda.arn
  test_client                 = local.environment == "development"
}