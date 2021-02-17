# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
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

data "azurerm_resources" "vnet" {
    type = "Microsoft.Network/virtualNetworks"
    name = var.vnet_name
    resource_group_name = var.vnet_rg
}

resource "random_password" "main" {
  length  = 32
  special = false
}


resource "azuread_application" "newapp" {
  display_name = "${var.prefix}-dbricks-sp"
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.newapp.application_id
}

resource "azuread_service_principal_password" "pass" {
  service_principal_id = azuread_service_principal.sp.id
  description = "Managed Password"
  value = random_password.main.result
  end_date_relative = "2400h30m"
}

resource "local_file" "sp_secret" {
    content  = random_password.main.result
    filename = "sp_secret.txt"
}



# App created as an Enterprise application, but not SCIM option yet
# resource "azuread_application" "enterprise" {
#   display_name = "${var.prefix}-Databricks-provisioning"
# }

# resource "azuread_service_principal" "this" {
#   application_id                = azuread_application.enterprise.application_id
#   tags = [
#     "WindowsAzureActiveDirectoryIntegratedApp",
#   ]
# }
