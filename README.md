# Notes
## Questions

- 00a- I’m downloading the file from an url in terraform. Maybe it’s better to have a “preparation task to do this”?
- 00a- To import it using the terraform module, the scripts need to be .py (ipynb not supported yet)
- 3a - We can save it locally or put it on a Key Vault.
- 3d - follow the article [here](https://docs.microsoft.com/en-us/azure/databricks/security/secrets/secret-scopes#create-an-azure-key-vault-backed-secret-scope-using-the-databricks-cli), we need to move it to step #4 maybe?
> I'm getting "Error: Azure KeyVault cannot yet be configured for Service Principal authorization" from the pipeline (with sp)
- 4b - Waiting for configuration if can be automated entirely… 4c should be automated?
- 4d - From what resource?
- Intermediate step (prerequisite for  step 5+)
    - Get email from group members of covid-admins
    - Get Secret created from step 4 for XYZ-Secrets
    - databricks_blobservice_fqdn
    - change var step4done = true
    - terraform import databricks_group.admin <id> (from the settings page)
    - terraform import terraform import azurerm_firewall_application_rule_collection.rules /subscriptions/b464a5af-90a6-414d-b676-cd2f9fa3a5a4/resourceGroups/canadastats-common/providers/Microsoft.Network/azureFirewalls/azFirewallDAaaS/applicationRuleCollections/dbfs-blob-storages
- 7 - Do we need to do exactly these steps or we need to give permissions to the AAD Group to the keyvault scope? 
- 11- Firewall option will not work from terraform module to just add. We can:
    - use our own rule collection name
	-  create an script using powershelgl


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