resource "aws_api_gateway_rest_api" "this" {
  name = "event_planr_api"

  tags = {
    project = "event-planr"
    service = "shared"
  }
}

resource "aws_api_gateway_resource" "test" {
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
  path_part   = "test"
}

resource "aws_api_gateway_method" "test" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.test.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "test" {
  rest_api_id          = aws_api_gateway_rest_api.this.id
  resource_id          = aws_api_gateway_resource.test.id
  http_method          = aws_api_gateway_method.test.http_method
  type                 = "MOCK"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.test.id,
      aws_api_gateway_method.test.id,
      aws_api_gateway_integration.test.id,
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
