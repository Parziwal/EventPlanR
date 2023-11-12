variable "user_pool_name" {
  description = "Name of the user pool"
  type        = string
}

variable "pre_token_generation_lambda" {
  description = "Arn of the lambda which customize identity token claims before token generation"
  type        = string
}

variable "test_client" {
  description = "Generate a OAuth client with UI for testing purposes"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags of the cognito resources"
  type        = map(string)
  default     = {}
}
