resource "aws_api_gateway_authorizer" "this" {
  name          = "event_planr_authorizer"
  type          = "COGNITO_USER_POOLS"
  rest_api_id   = aws_api_gateway_rest_api.this.id
  provider_arns = [aws_cognito_user_pool.this.arn]
}

resource "aws_cognito_resource_server" "this" {
  name       = "event_planr_resource_server"
  identifier = aws_api_gateway_stage.this.invoke_url

  user_pool_id = aws_cognito_user_pool.this.id
}