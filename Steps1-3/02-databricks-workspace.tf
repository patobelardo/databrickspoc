resource "azurerm_databricks_workspace" "dbricks" {
    name = "${var.prefix}-Databricks"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    sku = "premium"
    managed_resource_group_name = "COVID-dbricks-managed${var.prefix}"
    custom_parameters {
      virtual_network_id = data.azurerm_resources.vnet.resources[0].id
      private_subnet_name = azurerm_subnet.private_subnet.name
      public_subnet_name = azurerm_subnet.public_subnet.name
    }
}

provider "databricks" {
  azure_workspace_resource_id  = azurerm_databricks_workspace.dbricks.id
}
