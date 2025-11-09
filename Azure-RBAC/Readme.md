## What Is Azure RBAC?
RBAC: Role Base Access Control, lets you assign roles to users, groups, or applications at different scopes (management group, subscription, resource group, or at resource level). Each role defines what actions the assignee can perform. (The Principle of least privilege)

Below are some real-world examples both at Portal and CLI (Bash):

# Grant Developer Access to a Resource Group

- Use case: A developer needs full access to deploy resources in a specific resource group, command

- az role assignment create --assignee user-email --role "Contributor" --scope /subscriptions/sub-id/resourceGroups/rg-name

- Portal: Go to the resource group → Access Control (IAM) → Add role assignment → Select "Contributor" → Assign user.


# Restrict Access to Read-Only for Auditors

- Use Case: Auditors should view resources but not modify them, command 

- az role assignment create --assignee auditor-email --role "Reader" --scope /subscriptions/sub-id

- Portal: Subscription → Access Control (IAM) → Add role assignment → Select "Reader" → Assign auditor.


# Custom Role Creation (crc.json)

- Scenario: You want to allow a user to restart VMs but not modify them.

- Apply the crc.json file

- Outcome: You create a tailored role for specific operational needs.


# Assign Key Vault Access to an App

- Use Case: A web app needs to read secrets from Azure Key Vault, commad

- az role assignment create --assignee app-object-id --role "Key Vault Reader" --scope /subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.KeyVault/vaults/vault-name

- Portal: Key Vault → Access Control (IAM) → Add role assignment → Select "Key Vault Reader" → Assign app.


# Grant Storage Blob Access to Data Analyst

- Use Case: Analyst needs access to read blob data only.

- az role assignment create --assignee analyst-email --role "Storage Blob Data Reader" --scope /subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.Storage/storageAccounts/storage-name

- Portal: Storage Account → Access Control (IAM) → Add role assignment → Select "Storage Blob Data Reader".


# Assign Role to Azure AD Group

- Use Case: Assign access to a group instead of individuals.

- az role assignment create --assignee-object-id group-object-id --role "Contributor" --scope /subscriptions/sub-id/resourceGroups/rg-name

- Portal: Resource Group → Access Control (IAM) → Add role assignment → Assign to Azure AD group.


# Audit User Access to a Resource

- Use Case: Check what access a user has on a VM.

- az role assignment list --assignee user-email --scope /subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.Compute/virtualMachines/vm-name

- Portal: VM → Access Control (IAM) → Check Access → Enter user name → View roles.


# Remove Excess Permissions

- Use Case: Revoke unnecessary access from a user.

- az role assignment delete --assignee user-email --role "Contributor" --scope /subscriptions/sub-id/resourceGroups/rg-name

- Portal: Resource Group → Access Control (IAM) → Role assignments → Find user → Remove.


# Assign Role to Managed Identity

- Use Case: A function app needs access to a storage account.

- az role assignment create --assignee managed-identity-id --role "Storage Account Contributor" --scope /subscriptions/sub-id/resourceGroups/rg-name/providers/Microsoft.Storage/storageAccounts/storage-name

- Portal: Storage Account → Access Control (IAM) → Add role assignment → Assign to managed identity.


# Assign Role at Subscription Level

- Use Case: Cloud architect needs full access across the subscription.

- az role assignment create --assignee architect-email --role "Owner" --scope /subscriptions/sub-id

- Portal: Subscription → Access Control (IAM) → Add role assignment → Select "Owner".


## Fill in the necessary parameters and apply
