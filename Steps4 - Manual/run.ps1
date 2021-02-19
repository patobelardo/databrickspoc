PARAM(
    [Parameter(Mandatory=$true)]
    $prefix
)

Write-Host "Using prefix: $prefix"

$keyvault_id=(az keyvault show -n $prefix-Secrets -g CAE-Prod-$prefix --query 'id').Replace("`"", "")
$databricks_token=(az keyvault secret show --name "WorkspaceToken" --vault-name $prefix-Secrets --query "value").Replace("`"", "")
$keyvault_uri=(az keyvault show -n $prefix-Secrets -g CAE-Prod-$prefix --query 'properties.vaultUri' ).Replace("`"", "")
$dbricks_id=(az resource show -g CAE-Prod-$prefix --resource-type Microsoft.Databricks/workspaces -n $prefix-Databricks  --query "id").Replace("`"", "")
$dbricks_uri=(az resource show -g CAE-Prod-$prefix --resource-type Microsoft.Databricks/workspaces -n $prefix-Databricks  --query "properties.workspaceUrl").Replace("`"", "")

Write-Host "KeyVault ID : $keyvault_id"
Write-Host "KeyVault URI: $keyvault_uri"
Write-Host "Databricks ID: $dbricks_id"

terraform plan -var prefix="$prefix" -var keyvault_id=$keyvault_id -var keyvault_uri=$keyvault_uri -var dbricks_id=$dbricks_id

terraform apply -var prefix="$prefix" -var keyvault_id=$keyvault_id -var keyvault_uri=$keyvault_uri -var dbricks_id=$dbricks_id


Write-Host "Please create: "
Write-Host " - Enterprise Application from Catalog (Databricks)"
Write-Host " - Name: $prefix-Databricks-provisioning"
Write-Host " - Add User and Groups: $prefix, Covid-Admin"
Write-Host " - Go to Provisioning:"
Write-Host "     - Privisioning Mode: Automatic"
Write-Host "     - Tenant URL: https://$dbricks_uri/api/2.0/preview/scim"
Write-Host "     - Token     : $databricks_token"
Write-Host "     - Test Connection & Save"
Write-Host "     - Start Provisioning"
Write-Host " - App Secret saved at workspace keyvault. Secret Name: DatabricksAppToken"
Write-Host "Done."
