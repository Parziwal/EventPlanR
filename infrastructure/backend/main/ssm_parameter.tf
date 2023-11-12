// ----------------------
// Backend Parameters
// ----------------------

resource "aws_ssm_parameter" "cognito_user_pool_id" {
  name  = "/${local.environment}/event_planr/CognitoUserPoolOptions/UserPoolId"
  type  = "String"
  value = module.event_planr_auth.user_pool_id
}

resource "aws_ssm_parameter" "event_planr_db" {
  name  = "/${local.environment}/event_planr/ConnectionStrings/EventPlanrDb"
  type  = "SecureString"
  value = "Host=${module.event_planr_db.cluster_url};Port=5432;Username=${module.event_planr_db.username};Password=${module.event_planr_db.password};Database=${module.event_planr_db.database_name}"
}

resource "aws_ssm_parameter" "user_claim" {
  name  = "/${local.environment}/event_planr/DynamoDbTableOptions/UserClaimTable"
  type  = "String"
  value = aws_dynamodb_table.user_claim.name
}

resource "aws_ssm_parameter" "user_reserved_ticket_order" {
  name  = "/${local.environment}/event_planr/DynamoDbTableOptions/UserReservedTicketOrderTable"
  type  = "String"
  value = aws_dynamodb_table.user_reserved_ticket_order.name
}

resource "aws_ssm_parameter" "chat_message" {
  name  = "/${local.environment}/event_planr/DynamoDbTableOptions/ChatMessageTable"
  type  = "String"
  value = aws_dynamodb_table.chat_message.name
}

resource "aws_ssm_parameter" "event_planr_images" {
  name  = "/${local.environment}/event_planr/S3BucketOptions/EventPlanrImagesBucket"
  type  = "String"
  value = aws_s3_bucket.event_planr_images.id
}

resource "aws_ssm_parameter" "reserved_ticket_order_expiration_queue" {
  name  = "/${local.environment}/event_planr/SqsQueueOptions/ReservedTicketOrderExpirationQueueName"
  type  = "String"
  value = aws_sqs_queue.reserved_ticket_order_expiration_queue.name
}

// ----------------------
// Frontend Parameters
// ----------------------

resource "aws_ssm_parameter" "aws_region" {
  name  = "/${local.environment}/event_planr/awsRegion"
  type  = "String"
  value = local.workspace.region
}

resource "aws_ssm_parameter" "event_planr_api_url" {
  name  = "/${local.environment}/event_planr/eventPlanrApiUrl"
  type  = "String"
  value = module.event_planr_api.api_gateway_url
}

resource "aws_ssm_parameter" "cognito_pool_id" {
  name  = "/${local.environment}/event_planr/cognitoPoolId"
  type  = "String"
  value = module.event_planr_auth.user_pool_id
}

resource "aws_ssm_parameter" "cognito_pool_client_id" {
  name  = "/${local.environment}/event_planr/cognitoPoolClientId"
  type  = "String"
  value = module.event_planr_auth.user_pool_client_id
}

resource "aws_ssm_parameter" "chat_message_graphql_url" {
  name  = "/${local.environment}/event_planr/chatMessageGraphqlUrl"
  type  = "String"
  value = aws_appsync_graphql_api.chat_message.uris["GRAPHQL"]
}

resource "aws_ssm_parameter" "nominatim_api_url" {
  name  = "/${local.environment}/event_planr/nominatimApiUrl"
  type  = "String"
  value = "https://nominatim.openstreetmap.org"
}
