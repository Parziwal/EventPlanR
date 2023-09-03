data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "get_user_events_lambda_access" {
  statement {
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${var.get_user_events_function_name}"
    ]
  }
}

resource "aws_iam_role_policy" "get_user_events_lambda_access" {
  name   = "${var.get_user_events_function_name}LambdaAccess"
  role   = module.event_general_api.role_id
  policy = data.aws_iam_policy_document.get_user_events_lambda_access.json
}
