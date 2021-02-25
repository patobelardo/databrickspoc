PARAM(
    [Parameter(Mandatory=$true)]
    $prefix
)

#Requisites
# databricks cli
# azure cli

$firewall_name="azFirewallDAaaS"
$firewall_rg="canadastats-common"
$firewall_rule_name="dbfs-blob-storages"

Write-Host "Using prefix: $prefix"

az extension add --name databricks | Out-Null
az extension add --name azure-firewall | Out-Null

$databricks_token=(az keyvault secret show --name "WorkspaceToken" --vault-name $prefix-Secrets --query "value").Replace("`"", "")
$dbricks_uri=(az resource show -g CAE-Prod-$prefix --resource-type Microsoft.Databricks/workspaces -n $prefix-Databricks  --query "properties.workspaceUrl").Replace("`"", "")

Write-Host "databricks_token: $databricks_token"
Write-Host "dbricks_uri: https://$dbricks_uri"

$env:DATABRICKS_HOST="https://$dbricks_uri"
$env:DATABRICKS_TOKEN=$databricks_token


#coviddata_admins_emails=$(az ad group member list --group CovidData-admins --query '[].userPrincipalName' -o json | tr '\n' ' ') # | sed "s/\"/'/g")
$response=Invoke-WebRequest -Uri https://$dbricks_uri/api/2.0/preview/scim/v2/Groups -Headers @{ "Authorization"="Bearer $databricks_token"; "Content-Type"="application/scim+json"; "Accept"="application/scim+json" }
$coviddata_admins_ids= (((ConvertFrom-Json $response.Content).Resources | Where-Object { $_.displayName -eq "Coviddata-admins" }).Members.Value) -join ","
$databricks_admin_group_id= ((ConvertFrom-Json $response.Content).Resources | Where-Object { $_.displayName -eq "admins" }).id
$databricks_blobservice_fqdn= (az databricks workspace show -n $prefix-Databricks -g CAE-Prod-$prefix --query 'parameters.storageAccountName.value').Replace("`"", "")
$databricksappsecret=(az keyvault secret show --name "DatabricksAppToken" --vault-name $prefix-Secrets --query "value")

$json = databricks clusters list --output JSON | ConvertFrom-Json
$dbricks_cluster_new_id=$json.clusters[0].cluster_id
$dbricks_id=(az resource show -g CAE-Prod-$prefix --resource-type Microsoft.Databricks/workspaces -n $prefix-Databricks  --query "id") # | tr -d \") 
$keyvault_id=(az keyvault show -n $prefix-Secrets -g CAE-Prod-$prefix --query 'id') # | tr -d \") 
$private_subnet_id=(az network vnet subnet show -g canadastats-common --vnet-name COVID-IaaSVNet -n $prefix-dbricks-private --query "id") # | tr -d \")
$public_subnet_id=(az network vnet subnet show -g canadastats-common --vnet-name COVID-IaaSVNet -n $prefix-dbricks-public --query "id") # | tr -d \")


Copy-Item terraform.tfvars.original terraform.tfvars
"databricks_admin_group_id=$databricks_admin_group_id" >> terraform.tfvars
"coviddata_admins_ids=[$coviddata_admins_ids]" >> terraform.tfvars
"public_subnet_id=$public_subnet_id" >> terraform.tfvars
"keyvault_id=$keyvault_id" >> terraform.tfvars
"databricks_blobservice_fqdn=`"$databricks_blobservice_fqdn.blob.core.windows.net`"" >> terraform.tfvars
"private_subnet_id=$private_subnet_id" >> terraform.tfvars
"databricksappsecret=$databricksappsecret" >> terraform.tfvars
"dbricks_cluster_new_id=`"$dbricks_cluster_new_id`"" >> terraform.tfvars
"dbricks_id=$dbricks_id" >> terraform.tfvars

#Firewall change. We are commenting out this in case needs further testing on real environment.
az network firewall application-rule create -f $firewall_name -n $prefix-dbfs -g $firewall_rg --protocols Https=443 -c $firewall_rule_name --source-addresses "*" --target-fqdns "$databricks_blobservice_fqdn.blob.core.windows.net"

$env:DATABRICKS_HOST=$null
$env:DATABRICKS_TOKEN=$null

#$env:TF_LOG="DEBUG"
#terraform plan -var prefix="$prefix" 

#terraform apply -var prefix="$prefix" --auto-approve

