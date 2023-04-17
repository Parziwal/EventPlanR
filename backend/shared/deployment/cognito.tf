resource "aws_cognito_user_pool" "this" {
  name = "event_planr_user_pool"

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length    = 8
    require_numbers   = true
    require_symbols   = false
    require_lowercase = true
    require_uppercase = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    name                     = "name"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
    string_attribute_constraints {
      min_length = 0                 
      max_length = 2048             
    }
  }

  tags = {
    project = "event-planr"
    service = "shared"
  }
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = "event-planr-domain"
  user_pool_id = aws_cognito_user_pool.this.id
}

resource "aws_cognito_user_pool_client" "this" {
  name = "mobile_client"

  user_pool_id    = aws_cognito_user_pool.this.id
  generate_secret = false
  explicit_auth_flows = [ "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH" ]
}