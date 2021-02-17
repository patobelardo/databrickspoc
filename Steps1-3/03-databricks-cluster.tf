// create PAT token to provision entities within workspace
resource "databricks_token" "pat" {
  comment          = "Provisined by Terraform script"
  lifetime_seconds = 8640000 #NoLimit is not working
}

// output token for other modules
output "databricks_token" {
  value       = databricks_token.pat.token_value
  description = "tf_pat_token_new"
  sensitive   = true
}

resource "databricks_cluster" "new" {
  cluster_name = "stndrd-gen14GB3C-0to2"
  autoscale {
    min_workers = 1
    max_workers = 2
  }
  spark_version           = "6.4.x-scala2.11"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = 60
}

resource "databricks_notebook" "setup" {
  source     = "assets/${basename(var.check_secret_scopes_url)}"
  path       = "/Setup/${basename(var.check_secret_scopes_url)}"
  language   = "PYTHON"
  depends_on = [shell_script.download_asset]
}
