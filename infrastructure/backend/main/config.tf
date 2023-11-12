terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "event-planr-terraform-state"
    key    = "event-planr-project"
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
    development = {
      region                 = "us-east-1"
      project                = "event_planr"
      lambda_source_dir      = "../../../backend/Serverless/{LAMBDA_FOLDER}/bin/Release/net6.0/publish"
      aspnetcore_environmnet = "Development"
      lambdas = {
        event_general_api        = "EventPlanr.EventGeneral.Api",
        event_manager_api        = "EventPlanr.EventManager.Api",
        organization_manager_api = "EventPlanr.OrganizationManager.Api",
        ticket_manager_api       = "EventPlanr.TicketManager.Api",
        ticket_order_api         = "EventPlanr.TicketOrder.Api",
        user_ticket_api          = "EventPlanr.UserTicket.Api",
        news_post_api            = "EventPlanr.NewsPost.Api",
        chat_manager_api         = "EventPlanr.ChatManager.Api",
      }
    }
    production = {
      region                 = "us-east-1"
      project                = "event_planr"
      lambda_source_dir      = "../../../backend/Serverless/{LAMBDA_FOLDER}/bin/Release/net6.0/publish"
      aspnetcore_environmnet = "Production"
      lambdas = {
        event_general_api        = "EventPlanr.EventGeneral.Api",
        event_manager_api        = "EventPlanr.EventManager.Api",
        organization_manager_api = "EventPlanr.OrganizationManager.Api",
        ticket_manager_api       = "EventPlanr.TicketManager.Api",
        ticket_order_api         = "EventPlanr.TicketOrder.Api",
        user_ticket_api          = "EventPlanr.UserTicket.Api",
        news_post_api            = "EventPlanr.NewsPost.Api",
        chat_manager_api         = "EventPlanr.ChatManager.Api",
      }
    }
  }
  environment = contains(keys(local.env_vars), terraform.workspace) ? terraform.workspace : "development"
  workspace   = local.env_vars[local.environment]
}

data "aws_caller_identity" "default" {}
