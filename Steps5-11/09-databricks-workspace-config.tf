# Step 9
resource "databricks_workspace_conf" "this" {
  custom_config = {
    "enableResultsDownloading" = "false"
    "enableUploadDataUis" = "false"
    "enableExportNotebook" = "false"
    "enableNotebookTableClipboard" = "false"
  }
}
