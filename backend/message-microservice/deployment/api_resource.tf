data "aws_api_gateway_rest_api" "event_planr" {
  name = "event_planr_api"
}

data "aws_api_gateway_authorizers" "event_planr_authorizer" {
  rest_api_id = data.aws_api_gateway_rest_api.event_planr.id
}

resource "aws_api_gateway_resource" "message" {
  parent_id   = data.aws_api_gateway_rest_api.event_planr.root_resource_id
  rest_api_id = data.aws_api_gateway_rest_api.event_planr.id
  path_part   = "message"
}

resource "aws_api_gateway_resource" "users" {
  parent_id   = aws_api_gateway_resource.message.id
  rest_api_id = data.aws_api_gateway_rest_api.event_planr.id
  path_part   = "users"
}

resource "aws_api_gateway_method" "users" {
  rest_api_id   = data.aws_api_gateway_rest_api.event_planr.id
  resource_id   = aws_api_gateway_resource.users.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = data.aws_api_gateway_authorizers.event_planr_authorizer.ids[0]

  request_parameters = {
    "method.request.path.proxy" = true
    "method.request.header.Authorization" = true
  }
}

resource "aws_api_gateway_integration" "users" {
  rest_api_id             = data.aws_api_gateway_rest_api.event_planr.id
  resource_id             = aws_api_gateway_resource.users.id
  http_method             = aws_api_gateway_method.users.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_users.invoke_arn
}

resource "aws_lambda_permission" "users" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_users.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${data.aws_api_gateway_rest_api.event_planr.execution_arn}/*/GET/message/users"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = data.aws_api_gateway_rest_api.event_planr.id
  stage_name = "prod"

  lifecycle {
    create_before_destroy = true
  }
}