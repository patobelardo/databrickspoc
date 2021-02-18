# az ad group member list --group CovidData-admins --query '[].userPrincipalName' -o json
#coviddata_admins_emails = ["adminA@azinwcb023outlook.onmicrosoft.com","adminB@azinwcb023outlook.onmicrosoft.com"]
# read output step 4
#databricksappsecret = "w01axholnFtPDJe5IiIsGrPsExeqPfIn"
# at resources.azure.com
udr_id = "/subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/canadastats-common/providers/Microsoft.Network/routeTables/DbricksUDR"
firewall_name = "azFirewallDAaaS"
firewall_rg = "canadastats-common"
# az databricks workspace show -n BCD-Databricks -g CAE-Prod-BCD --query 'parameters.storageAccountName.value'
#databricks_blobservice_fqdn = "dbstoragedhlnc5o27b6um.blob.core.windows.net"
coviddata_admins_emails=[   "adminA@azinwcb023outlook.onmicrosoft.com",   "adminB@azinwcb023outlook.onmicrosoft.com" ] 
public_subnet_id="/subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/canadastats-common/providers/Microsoft.Network/virtualNetworks/COVID-IaaSVNet/subnets/BBD-dbricks-public"
keyvault_id="/subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/CAE-Prod-BBD/providers/Microsoft.KeyVault/vaults/BBD-Secrets"
databricks_blobservice_fqdn="dbstoragenx2q67y76r3ek.blob.core.windows.net"
private_subnet_id="/subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/canadastats-common/providers/Microsoft.Network/virtualNetworks/COVID-IaaSVNet/subnets/BBD-dbricks-private"
databricksappsecret="2qkQ8PJfVkjYemm4g2oINlv0501KnjJi"
dbricks_cluster_new_id="0218-140041-earth432"
dbricks_id="/subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/CAE-Prod-BBD/providers/Microsoft.Databricks/workspaces/BBD-Databricks"
firewall_rule_priority=101
