# Step 9
resource "databricks_workspace_conf" "this" {
  count =  var.step4done ? 1 : 0
  custom_config = {
    "enableResultsDownloading" = "false"
    "enableUploadDataUis" = "false"
    "enableExportNotebook" = "false"
    "enableNotebookTableClipboard" = "false"
  }
}
