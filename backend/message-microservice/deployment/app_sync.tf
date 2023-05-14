resource "aws_dynamodb_table" "message" {
  name           = "Message"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "conversationId"
  range_key      = "createdAt"

  attribute {
    name = "conversationId"
    type = "S"
  }

  attribute {
    name = "createdAt"
    type = "S"
  }
}

data "aws_iam_policy_document" "appsync_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["appsync.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "appsync_role" {
  name               = "appsync_role"
  assume_role_policy = data.aws_iam_policy_document.appsync_assume_role.json
}

data "aws_iam_policy_document" "allow_dynamodb" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:*"]
    resources = [aws_dynamodb_table.message.arn]
  }
}

resource "aws_iam_role_policy" "allow_dynamodb" {
  name   = "allow_dynamodb"
  role   = aws_iam_role.appsync_role.id
  policy = data.aws_iam_policy_document.allow_dynamodb.json
}

resource "aws_appsync_graphql_api" "this" {
  authentication_type = "API_KEY"
  name                = "event_planr_chat"

  schema = file("${path.module}/schema/schema.graphql")
}

resource "aws_appsync_api_key" "this" {
  api_id  = aws_appsync_graphql_api.this.id
  expires = "2023-06-03T04:00:00Z"
}

resource "aws_appsync_datasource" "this" {
  api_id           = aws_appsync_graphql_api.this.id
  name             = "tf_appsync_example"
  service_role_arn = aws_iam_role.appsync_role.arn
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = aws_dynamodb_table.message.name
  }
}

resource "aws_appsync_resolver" "chat_app_messages_resolver" {
  api_id            = aws_appsync_graphql_api.this.id
  type              = "Query"
  field             = "allMessages"
  data_source       = aws_appsync_datasource.this.name
  request_template  = file("${path.module}/schema/Query.allMessages.request.vtl")
  response_template = file("${path.module}/schema/Query.allMessages.response.vtl")
}

resource "aws_appsync_resolver" "chat_app_create_message_resolver" {
  api_id            = aws_appsync_graphql_api.this.id
  type              = "Mutation"
  field             = "createMessage"
  data_source       = aws_appsync_datasource.this.name
  request_template  = file("${path.module}/schema/Mutation.createMessage.request.vtl")
  response_template = file("${path.module}/schema/Mutation.createMessage.response.vtl")
}
