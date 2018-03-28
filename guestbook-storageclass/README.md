## PKS Guestbook App with Persistent Storage(via VCP/Hatchway) & Load Balancer
1. [ ] cd github/kubernetes/guestbook-storageclass
    1. [ ] kubectl apply -f .
    2. [ ] kubectl apply -f redis-sc.yaml
    3. [ ] kubectl apply -f redis-master-claim.yaml
    4. [ ] kubectl apply -f redis-slave-claim.yaml
2. [ ] kubectl apply -f guestbook-all-in-one.yaml
3. [ ] watch kubectl get pods -o wide
4. [ ] kubectl get sc
5. [ ] kubectl get pvc
6. [ ] kubectl get pv
7. [ ] kubectl describe sc thin-disk
8. [ ] In vCenter goto Datastore and see the two dynamically provisioned VMDK's.
    1. nfs-ubuntu-01 —> kubevols —> Refresh
9. [ ] watch kubectl get pods -o wide
10. [ ] kubectl get services
    1. NAME           TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
    2. frontend       LoadBalancer   10.100.200.46    10.40.14.39   80:32324/TCP   3m
11. [ ] Chrome - Access and test the Application - using Chrome
    1. Chrome http://10.40.13.39  
    2. Enter some text into the application which will be stored in the REDIS DB on Persistent Volumes.
    3. Show the Load Balancer that was created and the Virtual Servers etc.
12. kubectl get po -o wide
    1. redis-master-89d7df6bf-6wrlb   1/1       Running   0          3m
    2. redis-slave-7cf6774dbb-srdxg   1/1       Running   0          3m
13. kubectl delete po redis-master-89d7df6bf-6wrlb  redis-slave-7cf6774dbb-srdxg
14. watch kubectl get po -o wide
    1. Pods are recreated by the DEPLOYMENT automatically and should reconnect to the same Persistent Volumes
15. [ ] Chrome - TEST !!! - Access the Application again - It should have the same text you entered.
    1. 
16. NSX Manager - TraceFlow
