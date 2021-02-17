resource "azurerm_key_vault" "kv" {
  name                = "${var.prefix}-Secrets"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    secret_permissions = [
      "delete", "get", "list", "set", "recover"
    ]
  }
}

resource "databricks_secret_scope" "kv" {
  name = "${var.prefix}-Secrets"

  keyvault_metadata {
    resource_id = azurerm_key_vault.kv.id
    dns_name    = azurerm_key_vault.kv.vault_uri
  }
}