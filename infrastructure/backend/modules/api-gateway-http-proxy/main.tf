locals {
  createAuthorizer = length([
    for k, v in var.route_settings :
    k if v.use_authorization
  ]) > 0
}

resource "aws_apigatewayv2_api" "this" {
  name          = var.api_name
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["*"]
    allow_headers = ["*"]
    allow_methods = ["*"]
  }

  tags = var.tags
}

resource "aws_apigatewayv2_stage" "example" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}

data "aws_region" "current" {}

resource "aws_apigatewayv2_authorizer" "this" {
  count = local.createAuthorizer ? 1 : 0

  api_id           = aws_apigatewayv2_api.this.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "cognito-authorizer"

  jwt_configuration {
    audience = [var.cognito_pool_client_id]
    issuer   = "https://cognito-idp.${data.aws_region.current.name}.amazonaws.com/${var.cognito_pool_id}"
  }
}

resource "aws_apigatewayv2_integration" "this" {
  for_each = var.route_settings

  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = each.value.lambda_invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "this" {
  for_each = var.route_settings

  api_id             = aws_apigatewayv2_api.this.id
  route_key          = "ANY ${each.key}/{proxy+}"
  target             = "integrations/${aws_apigatewayv2_integration.this[each.key].id}"
  authorization_type = each.value.use_authorization ? "JWT" : null
  authorizer_id      = each.value.use_authorization ? aws_apigatewayv2_authorizer.this[0].id : null
}
