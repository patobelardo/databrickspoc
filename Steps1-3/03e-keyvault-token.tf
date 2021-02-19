#Save a secret with the databricks workspace token 
resource "azurerm_key_vault_secret" "token" {
  key_vault_id = azurerm_key_vault.kv.id
  name = "WorkspaceToken"
  value = databricks_token.pat.token_value
}