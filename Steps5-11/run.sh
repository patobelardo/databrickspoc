if [ -z "$1" ]; then
    echo "You muy include a prefix"
    exit 1
fi
if [ -z "$2" ]; then
    echo "You muy include a secret"
    exit 1
fi

# To Install pip
#sudo easy_install pip

echo "Using prefix: $1"
echo "App Secret: $2"

az extension add --name databricks
export DATABRICKS_HOST=asd
export DATABRICKS_TOKEN=asd
coviddata_admins_emails=$(az ad group member list --group CovidData-admins --query '[].userPrincipalName' -o json | tr '\n' ' ') # | sed "s/\"/'/g")
databricks_blobservice_fqdn=$(az databricks workspace show -n $1-Databricks -g CAE-Prod-$1 --query 'parameters.storageAccountName.value' | tr -d \") 
databricksappsecret="$2"
#TODO Get from Databricks CLI
dbricks_cluster_new_id="0218-182820-pit451"
dbricks_id=$(az resource show -g CAE-Prod-$1 --resource-type Microsoft.Databricks/workspaces -n $1-Databricks  --query "id") # | tr -d \") 
keyvault_id=$(az keyvault show -n $1-Secrets -g CAE-Prod-$1 --query 'id') # | tr -d \") 
private_subnet_id=$(az network vnet subnet show -g canadastats-common --vnet-name COVID-IaaSVNet -n $1-dbricks-private --query "id") # | tr -d \")
public_subnet_id=$(az network vnet subnet show -g canadastats-common --vnet-name COVID-IaaSVNet -n $1-dbricks-public --query "id") # | tr -d \")
#TODO Get from Databricks CLI
terraform import databricks_group.admin 3394478871036467
#TODO Get User Ids and group id, instead of importing
#TODO Firewall priority increasing (if we will create dynamic rules)
firewall_rule_priority=103

#echo "Admins : $coviddata_admins_emails"
#echo "databricks_blobservice_fqdn: $databricks_blobservice_fqdn"
#echo "DBricks Cluster ID: $dbricks_cluster_new_id"
#echo "KeyVault ID : $keyvault_id"
#echo "public_subnet_id : $public_subnet_id"
#echo "private_subnet_id : $private_subnet_id"


cp terraform.tfvars.original terraform.tfvars
echo "coviddata_admins_emails=$coviddata_admins_emails" >> terraform.tfvars
echo "public_subnet_id=$public_subnet_id" >> terraform.tfvars
echo "keyvault_id=$keyvault_id" >> terraform.tfvars
echo "databricks_blobservice_fqdn=\"$databricks_blobservice_fqdn.blob.core.windows.net\"" >> terraform.tfvars
echo "private_subnet_id=$private_subnet_id" >> terraform.tfvars
echo "databricksappsecret=\"$databricksappsecret\"" >> terraform.tfvars
echo "dbricks_cluster_new_id=\"$dbricks_cluster_new_id\"" >> terraform.tfvars
echo "dbricks_id=$dbricks_id" >> terraform.tfvars
echo "firewall_rule_priority=$firewall_rule_priority" >> terraform.tfvars


terraform plan -var prefix="$1"
terraform apply -var prefix="$1"

