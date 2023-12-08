terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "event-planr-terraform-state"
    key    = "event-planr-project-frontend"
    region = "us-east-1"
  }
}

provider "aws" {
  region = local.workspace.region

  default_tags {
    tags = {
      project     = local.workspace.project
      environment = local.environment
    }
  }
}

locals {
  env_vars = {
    default = {
      region  = "us-east-1"
      project = "event_planr"
    }
    development = {
    }
    production = {
    }
  }
  environment = contains(keys(local.env_vars), terraform.workspace) ? terraform.workspace : "development"
  workspace   = merge(local.env_vars["default"], local.env_vars[local.environment])
}
