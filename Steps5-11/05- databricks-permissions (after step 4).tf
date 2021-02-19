# Step 5
resource "databricks_group_member" "admin_console" {
  group_id = var.databricks_admin_group_id

  for_each = toset( var.coviddata_admins_ids )
  member_id = each.value
}
