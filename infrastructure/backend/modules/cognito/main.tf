resource "aws_cognito_user_pool" "this" {
  name = var.user_pool_name

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  lambda_config {
    pre_token_generation = var.pre_token_generation_lambda
  }

  password_policy {
    minimum_length                   = 8
    require_numbers                  = true
    require_symbols                  = false
    require_lowercase                = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
    string_attribute_constraints {
      min_length = 1
      max_length = 128
    }
  }

  schema {
    name                     = "given_name"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
    string_attribute_constraints {
      min_length = 1
      max_length = 64
    }
  }

  schema {
    name                     = "family_name"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
    string_attribute_constraints {
      min_length = 1
      max_length = 64
    }
  }

  schema {
    name                     = "picture"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true
  }

  tags = var.tags
}

resource "aws_cognito_user_pool_client" "mobile" {
  name = "mobile_pool_client"

  user_pool_id                  = aws_cognito_user_pool.this.id
  generate_secret               = false
  enable_token_revocation       = true
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows           = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
}

resource "aws_lambda_permission" "allow_execution_from_cognito" {
  statement_id  = "allow_execution_from_cognito"
  action        = "lambda:InvokeFunction"
  function_name = split(":", var.pre_token_generation_lambda)[6]
  principal     = "cognito-idp.amazonaws.com"

  source_arn = aws_cognito_user_pool.this.arn
}

resource "aws_cognito_user_pool_domain" "test" {
  count = var.test_client ? 1 : 0

  domain       = "event-planr-auth-test"
  user_pool_id = aws_cognito_user_pool.this.id
}

resource "aws_cognito_user_pool_client" "test" {
  count = var.test_client ? 1 : 0

  name = "test_client"

  user_pool_id    = aws_cognito_user_pool.this.id
  generate_secret = false

  callback_urls                        = ["http://localhost"]
  logout_urls                          = ["http://localhost"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  supported_identity_providers         = ["COGNITO"]
  prevent_user_existence_errors        = "ENABLED"
}
