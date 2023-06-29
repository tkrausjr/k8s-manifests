## PKS Guestbook App with PVs & SVC type LoadBalancer
1. cd github/kubernetes/guestbook-storageclass
2. kubectl apply -f .
    
    OR
    
2. kubectl apply -f redis-sc.yaml
3. kubectl apply -f redis-master-claim.yaml
4.  kubectl apply -f redis-slave-claim.yaml
5.  kubectl apply -f guestbook-all-in-one.yaml
6.  watch kubectl get pods -o wide
7.  kubectl get sc
8.  kubectl get pvc
9.  kubectl get pv
10.  kubectl describe sc thin-disk1
11. In vCenter goto Datastore and see the two dynamically provisioned VMDK's.
    1. nfs-ubuntu-01 —> kubevols —> Refresh
12.  watch kubectl get pods -o wide
13.  kubectl get services
    1. NAME           TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
    2. frontend       LoadBalancer   10.100.200.46    10.40.14.39   80:32324/TCP   3m
14.  Chrome - Access and test the Application - using Chrome
    1. Chrome http://10.40.13.39  
    2. Enter some text into the application which will be stored in the REDIS DB on Persistent Volumes.
    3. Show the Load Balancer that was created and the Virtual Servers etc.
15. kubectl get po -o wide
    1. redis-master-89d7df6bf-6wrlb   1/1       Running   0          3m
    2. redis-slave-7cf6774dbb-srdxg   1/1       Running   0          3m
16. kubectl delete po redis-master-89d7df6bf-6wrlb  redis-slave-7cf6774dbb-srdxg
17. watch kubectl get po -o wide
    1. Pods are recreated by the DEPLOYMENT automatically and should reconnect to the same Persistent Volumes
18.  Chrome - TEST !!! - Access the Application again - It should have the same text you entered.
    1. 
19. NSX Manager - TraceFlow
