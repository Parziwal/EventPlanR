variable "user_pool_name" {
  description = "Name of the user pool"
  type        = string
}

variable "tags" {
  description = "Tags of the cognito resources"
  type        = map(string)
  default     = {}
}
