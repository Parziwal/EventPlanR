resource "aws_dynamodb_table" "event_ticket" {
  name           = "EventTicket"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "eventId"
  range_key      = "name"

  attribute {
    name = "eventId"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }
}

resource "aws_dynamodb_table" "sold_ticket" {
  name           = "SoldTicket"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "eventId"
  range_key      = "id"

  attribute {
    name = "eventId"
    type = "S"
  }

  attribute {
    name = "id"
    type = "S"
  }
}