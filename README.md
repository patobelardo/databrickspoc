# Notes
## Questions

- 00a- I’m downloading the file from an url in terraform. Maybe it’s better to have a “preparation task to do this”?
- 00a- To import it using the terraform module, the scripts need to be .py (ipynb not supported yet)
- 3a - We can save it locally or put it on a Key Vault.
- 4b - Waiting for configuration if can be automated entirely… 4c should be automated?
- 4d - From what resource?
- Intermediate step (prerequisite for  step 5+)
    - Get email from group members of covid-admins
    - Get Secret created from step 4 for XYZ-Secrets
    - databricks_blobservice_fqdn
    - change var step4done = true
- 7 - Do we need to do exactly these steps or we need to give permissions to the AAD Group to the keyvault scope? 
- 11- Firewall option will not work from terraform module to just add. We can:
    - use our own rule collection name
	-  create an script using powershelgl
