resource "aws_api_gateway_rest_api" "this" {
  name = "event_planr_api"
}

resource "aws_api_gateway_resource" "this" {
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "any" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}