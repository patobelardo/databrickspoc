# Create cluster
resource "shell_script" "download_asset" {
  lifecycle_commands {
    create = "pwsh ${path.module}/scripts/getassets.ps1 -type create"
    read   = "pwsh ${path.module}/scripts/getassets.ps1 -type read"
    update = "pwsh ${path.module}/scripts/getassets.ps1 -type update"
    delete = "pwsh ${path.module}/scripts/getassets.ps1 -type delete"
  }

  working_directory = path.module

  environment = {
    assets_url = var.check_secret_scopes_url
    debug_log  = true
  }
}
