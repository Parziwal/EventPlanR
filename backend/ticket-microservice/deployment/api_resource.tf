data "aws_api_gateway_rest_api" "event_planr" {
  name = "event_planr_api"
}

data "aws_api_gateway_authorizers" "event_planr_authorizer" {
  rest_api_id = data.aws_api_gateway_rest_api.event_planr.id
}

resource "aws_api_gateway_resource" "ticket" {
  parent_id   = data.aws_api_gateway_rest_api.event_planr.root_resource_id
  rest_api_id = data.aws_api_gateway_rest_api.event_planr.id
  path_part   = "ticket"
}

resource "aws_api_gateway_resource" "ticket_proxy" {
  parent_id   = aws_api_gateway_resource.ticket.id
  rest_api_id = data.aws_api_gateway_rest_api.event_planr.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "ticket_proxy" {
  rest_api_id   = data.aws_api_gateway_rest_api.event_planr.id
  resource_id   = aws_api_gateway_resource.ticket_proxy.id
  http_method   = "ANY"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = data.aws_api_gateway_authorizers.event_planr_authorizer.ids[0]

  request_parameters = {
    "method.request.path.proxy" = true
    "method.request.header.Authorization" = true
  }
}

resource "aws_api_gateway_integration" "ticket_proxy" {
  rest_api_id             = data.aws_api_gateway_rest_api.event_planr.id
  resource_id             = aws_api_gateway_resource.ticket_proxy.id
  http_method             = aws_api_gateway_method.ticket_proxy.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.event_ticket_api.invoke_arn
}

resource "aws_lambda_permission" "event" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.event_ticket_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${data.aws_api_gateway_rest_api.event_planr.execution_arn}/*/*/ticket/*"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = data.aws_api_gateway_rest_api.event_planr.id
  stage_name = "prod"

  lifecycle {
    create_before_destroy = true
  }
}