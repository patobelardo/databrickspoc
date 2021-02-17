prefix = "DDE"
vnet_name = "COVID-IaaSVNet"
vnet_rg = "canadastats-common"
subnet_cidr_public = "10.0.0.192/26"
subnet_cidr_private = "10.0.1.0/26"
# needed to convert to .py
check_secret_scopes_url = "https://terraformlabcanadastats.blob.core.windows.net/notebooks/Check Secret Scopes.py"
step4done = false
# az ad group member list --group CovidData-admins --query '[].userPrincipalName' -o json
coviddata_admins_emails = ["adminA@azinwcb023outlook.onmicrosoft.com","adminB@azinwcb023outlook.onmicrosoft.com"]
# read output step 4
databricksappsecret = "w01axholnFtPDJe5IiIsGrPsExeqPfIn"
# at resources.azure.com
udr_id = "/subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/canadastats-common/providers/Microsoft.Network/routeTables/DbricksUDR"
firewall_name = "azFirewallDAaaS"
firewall_rg = "canadastats-common"
# az databricks workspace show -n BCD-Databricks -g CAE-Prod-BCD --query 'parameters.storageAccountName.value'
databricks_blobservice_fqdn = "dbstoragedhlnc5o27b6um.blob.core.windows.net"