
# List the available addons and addonreleases you can install
https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vcf-service-administration-and-development/9-0/managing-vsphere-kuberenetes-service-clusters-and-workloads/managing-add-ons-in-vks-clusters/view-available-addons.html

# Label the cluster according to the addons it needs
```
k label cluster/demo-cl01 -n shared-svcs-7w8d9 addons-install=headlamp    
    cluster.cluster.x-k8s.io/demo-cl01 labeled
```
# Modify the headlamp-labels.yaml with the label in the selector field

# Install

# To troubleshoot,
```
vcf context use supervisor-ctx
k get addoninstalls -n shared-svcs-7w8d9
    NAME       ADDON      PAUSED   AGE
    headlamp   headlamp            52m
k get addoninstalls -n shared-svcs-7w8d9 -oyaml | yq .status
# Note this shows a cluster was found and matched by the labels

# Switch to Cluster context
vcf context use demo-cl01
k get package -A
k get pkgi -A
k get po -A
k get app -A
    Shows headlamp in vmware-system-tkg Namespace with Reconcile failed.
k get app -n vmware-system-tkg demo-cl01-headlamp -oyaml 
k get pkgi demo-cl01-headlamp -n vmware-system-tkg -oyaml

# To test Navneets full nav-full-headlamp-exmpample-testing.yaml
# Note this -testing version looks for the addons-install=headlamp   LABEL and installs the addons on any cluster with this label.
```
1 - Create a addons-testing vSphere Namespace
```
cd ~/Downloads/vks/
k apply -f add-ons/nav-full-headlamp-example.yaml                 
    addoninstall.addons.kubernetes.vmware.com/cluster-headlamp created
    addonconfig.addons.kubernetes.vmware.com/workload-vsphere-vks1-headlamp created
    addoninstall.addons.kubernetes.vmware.com/cluster-cert-manager created
    addoninstall.addons.kubernetes.vmware.com/cluster-prom created
    addonconfig.addons.kubernetes.vmware.com/workload-vsphere-vks1-prometheus created
    addoninstall.addons.kubernetes.vmware.com/cluster-istio created
    addonconfig.addons.kubernetes.vmware.com/workload-vsphere-vks1-istio created
k get addoninstalls -A -n addons-testing                       
    NAMESPACE                  NAME                                            ADDON                  PAUSED   AGE
    addons-testing             cluster-cert-manager                            cert-manager                    29s
    addons-testing             cluster-headlamp                                headlamp                        29s
    addons-testing             cluster-istio                                   istio                           29s
    addons-testing             cluster-prom                                    prometheus                      29s

kctx supervisor-ctx:addons-testing
k get clusteraddon
```
## Create the workload cluster
```
k apply -f add-ons/workload-vsphere-vks1-cluster.yaml
    cluster.cluster.x-k8s.io/workload-vsphere-vks1 created

k label cluster/demo-cl01 -n shared-svcs-7w8d9 addons-install=headlamp    
    cluster.cluster.x-k8s.io/demo-cl01 labeled
```
## Validate that the add-ons were installed to the cluster.
```
# Depending on the type of vSphere Namespace where cluster lives you will create a Cluster Context.

# Option 1-Creates a context for a k8s (vSphere UI) created vSphere Namespace

vcf context create supervisor-wkld-a -e 10.1.8.132 -u administrator@wld.sso --insecure-skip-tls-verify --auth-type basic
```
## This will provide contexts for Supervisor and all Namespaces, To add an VKS cluster context as well for a cluster in the vSphere Namespace. 
```
vcf context create vks-01-headlamp -e 10.1.8.132 -u administrator@wld.sso --insecure-skip-tls-verify --workload-cluster-name  vks-01-headlamp-addon --workload-cluster-namespace addons-testing
vcf context use vks-01-headlamp:vks-01-headlamp-addon 
k get no
```

# Option 2-Creates a context for a CCI (VCFA) created vSphere Namespace & Cluster
```
# Assumes you already created the VCFA context with your --api-token -type CCI.
# Now we need the context for the cluster itself.

vcf context use vcfa:addons-testing-vzd34j:default-project
vcf cluster list
   kubernetes-cluster-v32p
vcf cluster register-vcfa-jwt-authenticator kubernetes-cluster-v32p
vcf cluster kubeconfig get kubernetes-cluster-v32p --admin
    Credentials of cluster 'kubernetes-cluster-v32p' have been saved 
    You can now access the cluster by running 'kubectl config use-context kubernetes-cluster-v32p-admin@kubernetes-cluster-v32p'
kctx kubernetes-cluster-v32p-admin@kubernetes-cluster-v32p 
k get no


kctx workload-vsphere-vks1:workload-vsphere-vks1

k get app -A
k get pkgi -A

k get all -n headlamp                
    NAME                            READY   STATUS    RESTARTS   AGE
    pod/headlamp-774b46b99b-xd4d6   1/1     Running   0          17m
    NAME               TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)         AGE
    service/headlamp   LoadBalancer   240.1.6.117   10.1.8.140    443:31773/TCP   21m

    NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/headlamp   1/1     1            1           21m
    NAME                                  DESIRED   CURRENT   READY   AGE
    replicaset.apps/headlamp-774b46b99b   1         1         1       21m
```
#
# Now to access headlamp and test it.
[Broadcom Reference]
https://techdocs.broadcom.com/us/en/vmware-cis/vcf/vcf-consumption/latest/managing-vsphere-kuberenetes-service-clusters-and-workloads/installing-standard-packages-on-tkg-service-clusters/installing-standard-packages-on-tkg-cluster-using-tkr-for-vsphere-8-x/install-headlamp/service-expose.html

# Create SA & Token (The clusterrolebinding already exists)
```
kubectl -n kube-system create serviceaccount headlamp-admin
    serviceaccount/headlamp-admin created

#Create the CRB
kubectl create clusterrolebinding headlamp-admin-two --serviceaccount=kube-system:headlamp-admin --clusterrole=cluster-admin
    clusterrolebinding.rbac.authorization.k8s.io/headlamp-admin created

 k create token headlamp-admin -n kube-system
eyJhbGciOiJSUzI1NiIsImtpZCI6IkNWdERocnhJclRvNzBsa1h0T0xqTkFqcnpJYWxERVNaNjhpMlpkV0Q5WVEifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNzgyNDEzMDU5LCJpYXQiOjE3ODI0MDk0NTksImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiYzlhMDI3ZGYtMWJiNC00MWRkLWFjOTctNDFjNzMwYTk5YTViIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJoZWFkbGFtcC1hZG1pbiIsInVpZCI6ImQxODVhMDI0LTVjZmMtNGE2NC1iNDRmLTRlNzAxOThhMWY0YiJ9fSwibmJmIjoxNzgyNDA5NDU5LCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06aGVhZGxhbXAtYWRtaW4ifQ.qBd0P2haL07dXVtV_ITWYEeOLM5dOChNJAbJswMeTS2xycvK1MK3HOQcqxKFVVw_3LuHDRB_zvnUVxrABKjSqdxgwcENoZroIFEO5Wqv30jzQzWWEWgfsYy6fEX56tf6s_4BRR8VaPoAY0TLS7QCc9lZPupXt8axIsTAqKlfpDij8EaxoZ2HvSnTLSN8ql_DkxbTb2mvRTNoue-HngfX0_Y6-B9_39SARPEKMtyz9xDELmLea1v-a7OCJJjKsmPLAYv75jCOaloSdYO_AsIJyDW0InAtpdVM3oJF-NSREz7ipvRDegJqHsBpcWGRsnAfu-Z1EE4E4aEZJX6fCTDECg
```


In Firefox access the External IP on https
https://10.1.8.140
PASTE in the TOKEN from above.
SUCCESS HEADLAMP UI 
But we need a Service Account Token
SUCCESS
