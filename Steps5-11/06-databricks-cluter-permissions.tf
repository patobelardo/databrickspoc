#Step 6
resource "databricks_permissions" "cluster_usage" {
  cluster_id = var.dbricks_cluster_new_id
  
  access_control {
    group_name = var.prefix
    permission_level = "CAN_RESTART"
  }
}
