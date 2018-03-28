# k8s-manifests

Assumes you have already created a PKS/K8s Cluster with something similar to below.
1. [ ] pks login -a uaa-svr.domain-name.com -u alana -p somepassword -k
2. [ ] pks create-cluster ga-routed-demo --external-hostname ga-demo2.domain-name.com --plan small --num-nodes 2
3. [ ] pks get-credentials ga-routed-demo
1. [ ] pks cluster ga-demo
    1. Kubernetes Master IP(s):  10.41.0.2
    2. [ ] NOTE: We have routed access to the K8S Master node in this setup (10.41.0.2) but the CERTIFICATES were generated with the —external-hostname parameter which is ga-demo2.domain-name.com which means that is how we will need to address the Master node. To accomplish this we will need to add a DNS entry for this hostname and IP
2. [ ] echo "10.41.0.2   ga-demo2.domain-name.com" >> /etc/hosts
3. [ ] kubectl config get-contexts
4. [ ] kubectl config use-context ga-demo
5. [ ] kubectl get nodes -o wide
