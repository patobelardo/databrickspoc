# Step 11
#IMPORTANT: This will remove other rules... will not work adding just this. It's an option to have a different rule name?
resource "azurerm_firewall_application_rule_collection" "rules" {
  name = "dbfs-blob-storages-${var.prefix}"
  azure_firewall_name = var.firewall_name
  resource_group_name = var.firewall_rg
  priority = var.firewall_rule_priority  
  action = "Allow"

  rule {
    name = "${var.prefix}-dbfs"
    source_addresses = [ "*" ]
    protocol {
      port = 443
      type = "Https"
    }
    target_fqdns = [ var.databricks_blobservice_fqdn ]
  }
}