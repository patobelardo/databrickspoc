#Step 8
resource "azuread_application" "newapp" {
  display_name = "${var.prefix}-dbricks-sp"
}

resource "azurerm_key_vault_secret" "clientid" {
  key_vault_id = var.keyvault_id
  name = "DataBricksClientID"
  value = azuread_application.newapp.application_id
}

resource "azurerm_key_vault_secret" "secret" {
  key_vault_id = var.keyvault_id
  name = "DataBricksSecret"
  value = var.databricksappsecret
}