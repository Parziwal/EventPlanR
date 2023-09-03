variable "api_name" {
  description = "Name of the API gateway"
  type        = string
}

variable "route_settings" {
  description = "Route settings of the API Gateway (key=path, value=route settings)"
  type = map(object({
    lambda_invoke_arn = string
    use_authorization = bool
  }))
}

variable "cognito_pool_id" {
  description = "Id of the cognito user pool"
  type        = string
  default     = null
}

variable "cognito_pool_client_id" {
  description = "Id of the cognito user pool client"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags of the API Gateway resources"
  type        = map(string)
  default     = {}
}
