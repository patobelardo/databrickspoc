if [ -z "$1" ]; then
    echo "You muy include a prefix"
    exit 1
fi
echo "Using prefix: $1"
keyvault_id=$(az keyvault show -n $1-Secrets -g CAE-Prod-$1 --query 'id' | tr -d \") 
keyvault_uri=$(az keyvault show -n $1-Secrets -g CAE-Prod-$1 --query 'properties.vaultUri' | tr -d \") 
dbricks_id=$(az resource show -g CAE-Prod-$1 --resource-type Microsoft.Databricks/workspaces -n $1-Databricks  --query "id" | tr -d \") 
dbricks_uri=$(az resource show -g CAE-Prod-$1 --resource-type Microsoft.Databricks/workspaces -n $1-Databricks  --query "properties.workspaceUrl" | tr -d \") 

echo "KeyVault ID : $keyvault_id"
echo "KeyVault URI: $keyvault_uri"
echo "Databricks ID: $dbricks_id"

terraform plan -var prefix="$1" -var keyvault_id=$keyvault_id -var keyvault_uri=$keyvault_uri -var dbricks_id=$dbricks_id

terraform apply -var prefix="$1" -var keyvault_id=$keyvault_id -var keyvault_uri=$keyvault_uri -var dbricks_id=$dbricks_id


echo "Please create: "
echo " - Enterprise Application from Catalog (Databricks)"
echo " - Name: $1-Databricks-provisioning"
echo " - Add User and Groups: $1, Covid-Admin"
echo " - Go to Provisioning:"
echo "     - Privisioning Mode: Automatic"
echo "     - Tenant URL: https://$dbricks_uri/api/2.0/preview/scim"
echo "     - Token     : check email"
echo "     - Test Connection & Save"
echo "     - Start Provisioning"
echo " - Share this secret with the provisioning team (databricksappsecret): "
cat sp_secret.txt
echo "Done."
