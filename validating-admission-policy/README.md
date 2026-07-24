
# Resources
```
First example is setting policy through VCFA which does ValidatingAdmissionPolicy on backend
```
- https://blogs.vmware.com/cloud-foundation/2025/10/01/vmware-cloud-foundation-automation-infrastructure-resource-policy-overview/
- https://vmw-confluence.broadcom.net/spaces/WCP/pages/2403636802/Add-on+Management+System+How-To+use+VCFA+policy+management
- https://oneuptime.com/blog/post/2026-02-09-cel-validating-admission-policy/view
- https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy/
- https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/validating-admission-policy-binding-v1/

### Simple Test done at a VKS Cluster level with Springone K8s Deployment and replica count
```
cd k8s-manifests
k apply -f validating-admission-policy/basic-replica-vap.yaml
k apply -f validating-admission-policy/basic-replica-vap-binding.yaml
k apply -f validating-admission-policy/springone-deploy.yaml
```
## Since replica count = 6 and that is more than the policy limit deployment fails.

## Troubleshoot policy violations inside a VKS cluster OR a vSphere Namespace.
```
# Check the api-server logs for Policy events
k logs -n kube-system kube-apiserver-4227e0f6113a21cb67814a8efd676448 | grep ValidatingAdmissionPolicy
```
# List policies and policy bindings in a vSphere Namespace or inside a VKS Cluster
```
k get validatingadmissionpolicy,validatingadmissionpolicybindings
```


# Testing Controlling VKS Cluster deployments inside a vSphere Namespace
```
vcf context use supervisor-ctx:demo-ns-vsphere
cd k8s-manifests
k apply -f ./validating-admission-policy/cluster-replica-vap.yaml
k apply -f ./validating-admission-policy/cluster-replica-vap-binding.yaml

# Now test the cluster deploymenty
k apply -f ./validating-admission-policy/vks-cluster-replica-test.yaml
$$$  NOT WORKING YET Cluster can still deploy with more replicas than specified
```



