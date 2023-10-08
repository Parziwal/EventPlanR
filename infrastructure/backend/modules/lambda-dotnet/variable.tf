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

variable "role_arn" {
  description = "The arn of them lambda role policy"
  type        = string
}

variable "environment_varibles" {
  description = "Environment variables for the lambda function"
  type        = map(string)
  default     = {}
}

variable "memory_size" {
  description = "Size of the lambda memory"
  type        = number
  default     = 512
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this lambda function"
  type        = number
  default     = -1
}

variable "tags" {
  description = "Tags of the lambda resources"
  type        = map(string)
  default     = {}
}
