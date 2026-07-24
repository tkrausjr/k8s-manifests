
# Resources

https://oneuptime.com/blog/post/2026-02-09-cel-validating-admission-policy/view
https://kubernetes.io/docs/reference/kubernetes-api/admissionregistration/validating-admission-policy-binding-v1/

# Simple Test done at a VKS Cluster level with Deployment and replica count
```
k apply -f basic-replica-vap.yaml
k apply -f basic-replica-vap-binding.yaml
k apply -f springone-deploy.yaml
```
## Since replica count = 6 and that is more than the policy limit deployment fails.

## Troubleshoot policy violations inside a VKS cluster OR a vSphere Namespace.
```
# Check the api-server logs for Policy events
k logs -n kube-system kube-apiserver-4227e0f6113a21cb67814a8efd676448 | grep ValidatingAdmissionPolicy
```
# List policies and policy bindings in a vSphere Namespace or inside a VKS Cluster
```
k label cluster/demo-cl01 -n shared-svcs-7w8d9 addons-install=headlamp    
    cluster.cluster.x-k8s.io/demo-cl01 labeled
```


# Testing Controlling VKS Cluster deployments inside a vSphere Namespace
```
cd k8s-manifests
k apply -f ./validating-admission-policy/cluster-replica-vap.yaml
k apply -f ./validating-admission-policy/cluster-replica-vap-binding.yaml


```


