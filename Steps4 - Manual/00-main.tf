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

variable "keyvault_id" {
  type    = string
}

variable "keyvault_uri" {
  type    = string
}

variable "dbricks_id" {
  type = string
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

provider "databricks" {
  azure_workspace_resource_id = var.dbricks_id
}

#From 3d
resource "databricks_secret_scope" "kv" {
  name = "${var.prefix}-Secrets"

  keyvault_metadata {
    resource_id = var.keyvault_id
    dns_name    = var.keyvault_uri
  }
}