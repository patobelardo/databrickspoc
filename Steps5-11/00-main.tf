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
    container_name       = "terraform-state1"
    key                  = "terraform.tfstate1"
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
variable "coviddata_admins_emails" {
  type = list(string)
}
variable "firewall_name" {
  type = string
}
variable "firewall_rg" {
  type = string
}
variable "dbricks_id" {
  type = string
}
variable "keyvault_id" {
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

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "dbricks_cluster_new_id" {
  type = string
}

variable "firewall_rule_priority" {
  type = number
}

provider "databricks" {
  azure_workspace_resource_id = var.dbricks_id
}
