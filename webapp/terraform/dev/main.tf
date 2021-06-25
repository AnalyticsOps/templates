terraform {
  backend "azurerm" {
  }
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # version = "~>2.56.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration          = true
  features {
    key_vault {
      recover_soft_deleted_key_vaults = false
      purge_soft_delete_on_destroy    = false
    }
  }
}


variable "project_name" {
  type = string
}

variable "resource_number" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "alert_emails" {
  type    = list(string)
  default = []
}

variable "alert_frequency" {
  type    = number
  default = 60
}


data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}


resource "azurerm_container_registry" "cr" {
  name                = "cr${var.project_name}${var.environment_name}${var.resource_number}"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  sku                 = "Premium"
  admin_enabled       = true
}


module "model_deployment" {
  source = "git::https://github.com/AnalyticsOps/modeldeployment-terraform?ref=main"

  project_name        = var.project_name
  resource_number     = var.resource_number
  resource_group_name = var.resource_group_name
  environment_name    = var.environment_name
  alert_emails        = var.alert_emails
  alert_frequency     = var.alert_frequency
}
