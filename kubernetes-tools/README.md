# Tools and Techniques for troubleshooting Kubernetes

In-Cluster Network Troubleshooting
1. [ ] kubectl run nwtool --image praqma/network-multitool
2. [ ] kubectl get pods
   1. [ ] nwtool-5b447fbfd4-ctpfs        1/1     Running   0          16m 
3. [ ] kubectl exec -it nwtool-5b447fbfd4-ctpfs /bin/bash        # To run interactively
   1. [ ] bash-5.0#
4. [ ] kubectl exec -it nwtool-5b447fbfd4-ctpfs -- ping kubernetes.default        # To run in same command
