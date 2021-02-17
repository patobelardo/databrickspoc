#Previous to these steps we need to do:
# - terraform import databricks_group.admin <id> (from the settings page)
# - terraform import terraform import azurerm_firewall_application_rule_collection.rules /subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/canadastats-common/providers/Microsoft.Network/azureFirewalls/azFirewallDAaaS/applicationRuleCollections/dbfs-blob-storages

# Coming from Step 4
resource "azuread_group" "group" {
  display_name = var.prefix
}


# Step 5
resource "databricks_group" "admin" {
  display_name = "admins"
}

resource "databricks_user" "admins" {
  for_each = toset( var.coviddata_admins_emails )
  user_name = each.key
}

resource "databricks_group_member" "admin_console" {
  group_id = databricks_group.admin.id

  for_each = toset( var.coviddata_admins_emails )
  member_id = databricks_user.admins[each.key].id
}
