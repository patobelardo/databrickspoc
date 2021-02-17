#Step 8
resource "azuread_application" "newapp" {
  display_name = "${var.prefix}-dbricks-sp"
}

resource "azurerm_key_vault_secret" "clientid" {
  count =  var.step4done ? 1 : 0
  key_vault_id = azurerm_key_vault.kv.id
  name = "DataBricksClientID"
  value = azuread_application.newapp.application_id
}

resource "azurerm_key_vault_secret" "secret" {
  count =  var.step4done ? 1 : 0
  key_vault_id = azurerm_key_vault.kv.id
  name = "DataBricksSecret"
  value = var.databricksappsecret
}