variable "cluster_identifier" {
  description = "The identifier of the rds cluster"
  type        = string
}

variable "database_name" {
  description = "Name for an automatically created database on cluster creation"
}

variable "db_instance_count" {
  description = "Number of rds instances"
  type        = number
  default     = 1
}

variable "subnet_count" {
  description = "Number of subnets, required at least 2, maximum 8."
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum capacity for an db cluster"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity for an db cluster"
  type        = number
}

variable "tags" {
  description = "Tags of the rds resources"
  type        = map(string)
  default     = {}
}
