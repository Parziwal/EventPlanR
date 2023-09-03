variable "source_dir" {
  description = "Directory of the source code"
  type        = string
}

variable "function_name" {
  description = "The name of the lambda function"
  type        = string
}

variable "handler" {
  description = "The name of the handler method"
  type        = string
}

variable "environment_varibles" {
  description = "Environment variables for the lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags of the lambda resources"
  type = map(string)
  default = {}
}