if [ -z "$1" ]; then
    echo "You muy include a prefix"
    exit 1
fi
echo "Using prefix: $1"
keyvault_id=$(az keyvault show -n $1-Secrets -g CAE-Prod-$1 --query 'id')
keyvault_uri=$(az keyvault show -n $1-Secrets -g CAE-Prod-$1 --query 'properties.vaultUri')
dbricks_id=$(az resource show -g CAE-Prod-$1 --resource-type Microsoft.Databricks/workspaces -n $1-Databricks  --query "id")
echo "KeyVault ID : $keyvault_id"
echo "KeyVault URI: $keyvault_uri"
echo "Databricks ID: $dbricks_id"

terraform plan -var prefix="$1" -var keyvault_id=$keyvault_id -var keyvault_uri=$keyvault_uri -var dbricks_id=$dbricks_id

terraform apply -var prefix="$1" -var keyvault_id=$keyvault_id -var keyvault_uri=$keyvault_uri -var dbricks_id=$dbricks_id