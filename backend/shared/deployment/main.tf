resource "aws_apigatewayv2_api" "this" {
  name          = "event-planr-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "this" {
  api_id = aws_apigatewayv2_api.this.id
  name   = "development"
}