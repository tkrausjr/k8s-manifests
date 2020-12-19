## Network Policy - NSX

Background - Want to deploy web based application in sandbox and test it from another container in the same namespace, but NOT expose it outside the cluster or namespace
1. cd  /root/github/kubernetes/network-policy
2.  kubectl create namespace sandbox
3.  kubectl apply -f nsxpol-allow-8080-ns-sandbox.yaml
    1. THIS WILL BLOCK ALL TRAFFIC from entering the Sandbox Namespace except port 8080 which our application uses
4. kubectl apply -f go-conference-app-deploy.yaml
5. kubectl apply -f go-conference-app-service.yaml
6. kubectl get service -n sandbox
7. TEST THE APPLICATION from the External Service IP of the service in sandbox
    1. IT SHOULD WORK
8. kubectl get netpol -n sandbox
9. kubectl edit netpol sandbox-only-8080 -n sandbox
    1. Change the port to 443
    2. This will break the APP
10. NSX - Manager - Traceflow
    1. SRC - VM - vm-xxx878787
    2. DST - LogicalPort - pks- frontend Container
    3. This will show packet dropped by the firewall.
11. kubectl delete -f nsx-policy-deny-all-ns-sandbox.yaml
    1. Above will DELETE the policy
