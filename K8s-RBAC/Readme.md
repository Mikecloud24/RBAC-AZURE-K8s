## Common Kubernetes RBAC YAML Files

- Developer Access to a Namespace

- Read-Only Access for Auditors

- CI/CD Service Account Deployment Role

- Custom Role for Restarting Pods Only

- Monitoring Tool Access (Prometheus)


## Apply RBAC YAMLs with kubectl To Your Cluster

- kubectl apply -f dev-role.yaml

- kubectl apply -f audit-readonly.yaml

- kubectl apply -f cicd-deployer.yaml

- kubectl apply -f pod-restart.yaml

- kubectl apply -f prometheus-reader.yaml


## Test Permissions with kubectl auth can-i before applying

# This command helps you simulate what a user or service account can do. Common Examples:

- Can user create deployments in dev namespace?  

Use...  kubectl auth can-i create deployments --as=michael@example.com -n dev

- Can service account delete pods in staging?  

Use... kubectl auth can-i delete pods --as=system:serviceaccount:staging:cicd-pipeline -n staging

- Can group audit-team list secrets?

Use... kubectl auth can-i list secrets --as=system:serviceaccount:default:audit-team

- Can user restart pods cluster-wide?

Use.. kubectl auth can-i delete pods --as=ops-user@example.com --all-namespace


## Note:
- Use --as flag to provide a user or service account name

- Use --namespace to scope the check

- Combine with --list to see all permisions. Example... kubectl auth can-i --list --as=michael@example.com -n dev


## Optional: Clean Up Resources

- kubectl delete -f dev-role.yaml

- kubectl delete -f audit-readonly.yaml

- kubectl delete -f cicd-deployer.yaml

- kubectl delete -f pod-restart.yaml

- kubectl delete -f prometheus-reader.yaml


# To delete Roles and Binding use...

- kubectl delete role dev-developer -n dev

- kubectl delete rolebinding dev-developer-binding -n dev


## Best Practices for Kubernetes RBAC

1. Enforce Least Privilege:

- Grant only the permissions necessary for a task.

- Avoid using * (wildcard) verbs or resources unless absolutely required.


2. Use Namespaced Roles:

- Prefer Role and RoleBinding over cluster-wide equivalents to limit scope.

- Example: Assign Role to developers in dev namespace, not across the cluster.


3. Avoid Cluster-Admin Unless Necessary:

- The cluster-admin role bypasses all checks, use it only for trusted admins.

- Never assign this role to service accounts or external users.


4. Audit and Rotate Access:

- Regularly review RoleBindings and ClusterRoleBindings.

- Remove stale or unused bindings to reduce attack surface.


5. Use Groups for Access Control:

- Assign roles to groups instead of individuals for easier management.

- Integrate with identity providers (e.g., Azure AD, LDAP) for centralized control.


6. Protect Privileged Tokens:

- Avoid assigning powerful roles to service accounts used in public-facing pods.

- Use PodSecurityPolicies or PodSecurity Standards to restrict what pods can do.


7. Limit DaemonSet Permissions:

- DaemonSets run on all nodes, ensure they don’t have excessive access.

- Use node affinity and taints to isolate sensitive workloads.


8. Avoid system:masters Group:

- This group bypasses all RBAC checks and authorization webhooks.

- Never add users to this group unless absolutely necessary.


9. Use Open Policy Agent (OPA) for Advanced Control:

- Combine RBAC with OPA to enforce custom policies like time-based access or resource quotas.


10. Document and Version Your RBAC Policies:

- Store RBAC manifests in Git for version control.

- Use tools like kubectl auth can-i to test permissions before applying.
