# Notes
## Execution
- 1st Pipeline
- run.sh script from Steps4-Manual folder
Output Example:
````bash
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
Please create:
 - Enterprise Application from Catalog (Databricks)
 - Name: BBD-Databricks-provisioning
 - Add User and Groups: BBD, Covid-Admin
 - Go to Provisioning:
     - Privisioning Mode: Automatic
     - Tenant URL: https://adb-5679927609571559.19.azuredatabricks.net/api/2.0/preview/scim
     - Token     : check email
     - Test Connection & Save
     - Start Provisioning
 - Share this secret with the provisioning team (databricksappsecret):
2qkQ8PJfVkjYemm4g2oINlv0501KnjJi
Done.
````
- 2nd Pipeline (for now executing run.sh script - waiting for confirmation on some other questions)

## Questions

- 00a- I’m downloading the file from an url in terraform. Maybe it’s better to have a “preparation task to do this”?
- 00a- To import it using the terraform module, the scripts need to be .py (ipynb not supported yet)
- 3a - We can save it locally or put it on a Key Vault. -> To KeyVault (step 3e)
- 3d - follow the article [here](https://docs.microsoft.com/en-us/azure/databricks/security/secrets/secret-scopes#create-an-azure-key-vault-backed-secret-scope-using-the-databricks-cli), we need to move it to step #4 maybe?
> I'm getting "Error: Azure KeyVault cannot yet be configured for Service Principal authorization" from the pipeline (with sp)
- 4b - I'm waiting for confirmation if we can be automated entirely. If not: 4c should be automated?
- 4d - From what resource?  
>[From Databricks Workspace] 
- Intermediate step (prerequisite for  step 5+)
    - Get email from group members of covid-admins
    - Get Secret created from step 4 for XYZ-Secrets
    - databricks_blobservice_fqdn
    - change var step4done = true
    - terraform import databricks_group.admin <id> (from the settings page)
    - terraform import terraform import azurerm_firewall_application_rule_collection.rules /subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/canadastats-common/providers/Microsoft.Network/azureFirewalls/azFirewallDAaaS/applicationRuleCollections/dbfs-blob-storages
- 7 - Do we need to do exactly these steps or we need to give permissions to the AAD Group to the keyvault scope?
> databricks --profile XYZ secrets write-acl --scope XYZ-Secrets --permission READ --principal XYZ 
- 11- Firewall option will not work from terraform module to just add, it will try to recreate the entire rule. We can:
    - use our own rule collection name
	- create an script using powershell or similar


## Steps for github action workflow creation
### Creation of sp
````bash
az ad sp create-for-rbac --name "sp-databricks-poc-tf" --role Contributor --scopes /subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4 --sdk-auth
````
### Terraform
````bash
az group create -g databricks-tf -l canadacentral
az storage account create -n sadatabrickstf -g databricks-tf -l canadacentral --sku Standard_LRS
az storage container create -n terraform-state --account-name sadatabrickstf
````
