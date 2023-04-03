data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
/*
data "aws_iam_policy_document" "rds_access_policy" {
  statement {
    actions = [
    ]
    resources = [
    ]
  }
}
*/
resource "aws_iam_role" "lambda_rds_access_role" {
  name               = "lambda_rds_access_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}
/*
resource "aws_iam_role_policy" "rds_access_policy" {
  name   = "rds_access_policy"
  role   = aws_iam_role.lambda_rds_access_role.id
  policy = data.aws_iam_policy_document.rds_access_policy.json
}
*/