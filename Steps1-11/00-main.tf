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
variable "step4done" {
  type = bool
}
variable "coviddata_admins_emails" {
  type = list(string)
}
variable "firewall_name" {
  type = string
}
variable "firewall_rg" {
  type = string
}

variable "databricksappsecret" {
  type = string
}

#UDR ObjectID
variable "udr_id" {
  type = string
}

variable "databricks_blobservice_fqdn" {
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
