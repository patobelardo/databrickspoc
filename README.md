# Notes
## Execution
- 1st Pipeline
- run.ps1 script from Steps4-Manual folder
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
     - Token     : TOKEN
     - Test Connection & Save
     - Start Provisioning
 - Share this secret with the provisioning team (databricksappsecret):
2qkQ8PJfVkjYemm4g2oINlv0501KnjJi
Done.
````
- 2nd Pipeline (executing run.ps1 script)

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
