# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = ">= 1.3"
    }
    databricks = {
      source = "databrickslabs/databricks"
    }
    shell = {
      source = "scottwinkler/shell"
      version = "1.7.7"
    }
  }
  backend "azurerm" {
    resource_group_name  = "databricks-tf"
    storage_account_name = "sadatabrickstf"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

variable "prefix" {
  type    = string
  default = "XYZ"
}
variable "vnet_name" {
  type    = string  
}
variable "vnet_rg" {
  type    = string  
}
variable "subnet_cidr_public" {
  type    = string
}
variable "subnet_cidr_private" {
  type    = string
}
variable "check_secret_scopes_url" {
  type = string
}

data "azurerm_resources" "vnet" {
    type = "Microsoft.Network/virtualNetworks"
    name = var.vnet_name
    resource_group_name = var.vnet_rg
}

resource "azurerm_resource_group" "rg" {
  name     = "CAE-Prod-${var.prefix}"
  location = "canadacentral"
}
