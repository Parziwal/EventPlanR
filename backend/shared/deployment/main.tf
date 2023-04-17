resource "aws_api_gateway_rest_api" "this" {
  name = "event_planr_api"

  tags = {
    project = "event-planr"
    service = "shared"
  }
}

resource "aws_api_gateway_resource" "event_proxy" {
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "event_proxy" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.event_proxy.id
  http_method   = "ANY"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.this.id

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

data "aws_lambda_function" "aws_lambda_function" {
  function_name = "event_general_api"
}

resource "aws_lambda_permission" "event" {
  action        = "lambda:InvokeFunction"
  function_name = "event_general_api"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/ANY${aws_api_gateway_resource.event_proxy.path}"
}

resource "aws_api_gateway_integration" "event_proxy" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.event_proxy.id
  http_method             = aws_api_gateway_method.event_proxy.http_method
  integration_http_method = "ANY"
  type                    = "AWS_PROXY"
  uri                     = data.aws_lambda_function.aws_lambda_function.invoke_arn
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.event_proxy.id,
      aws_api_gateway_method.event_proxy.id,
      aws_api_gateway_integration.event_proxy.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "prod"
}
