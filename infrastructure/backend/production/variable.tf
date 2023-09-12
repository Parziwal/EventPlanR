variable "region" {
  description = "The specified region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The name of the environment"
  type        = string
  default     = "prod"
}

variable "tags" {
  description = "Tags of the resources"
  type        = map(string)
  default = {
    project     = "event_planr"
    environment = "production"
  }
}
