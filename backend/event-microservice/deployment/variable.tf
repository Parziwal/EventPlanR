variable "region" {
  description = "The specified region"
  type        = string
}

variable "environment" {
  description = "The name of the environment"
  type        = string
}

variable "event_general_api_source_dir" {
  description = "The location of the Event General Api directory"
  type        = string
}

variable "get_user_events_function_name" {
  description = "The name of the user events list lambda function"
  type        = string
}

variable "tags" {
  description = "Tags of the resources"
  type        = map(string)
}
