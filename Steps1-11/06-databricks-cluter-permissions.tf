#Step 6
resource "databricks_permissions" "cluster_usage" {
  cluster_id = databricks_cluster.new.id
  count =  var.step4done ? 1 : 0
  
  access_control {
    group_name = var.prefix
    permission_level = "CAN_RESTART"
  }
}
