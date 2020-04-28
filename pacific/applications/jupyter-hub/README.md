# jupyter-hub_on_vSphere7_w_Kubernetes
Instructions to get Jupyter Hub with embedded example notebooks for Machine Learning an Data Analysis using pandas and scitkitlearn deployed and running on Kubernetes TKG Guest Cluster running on vSphere 7 with Kubernetes.

## Requirements:
* Kubernetes TKG Guest Cluster running on vSphere 7(GA) with Kubernetes
* HELM 3.0 
* jupyterhub repo added to HELM.
* A K8s guest cluster deployed with updated Clusterrolebinding for PSP psp-system-privileged by system:authenticated
* A Storage Class configured

 
 ```
## Add the jupyterhub Repo to Helm

    `helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/` 
    `helm repo update`

## Install Jupyter-Hub Helm chart

Clone this repository for a working values file (data-science-jhub-values.yaml) to use for installation.
     `git clone https://github.com/tkrausjr/k8s-manifests.git  `
     `cd ./k8s-manifests/jupyter-hub  `

From a Linux machine, generate a random hex string to be used as a security token by Jupyter Hub.

    `openssl rand -hex 32`
    `c46350ed823f9433312d110bf39700a765ee3cbc08f0220dff86cc63a570d3be`

Get the name of a StorageClass in kubernetes that you can use
    'kubectl get sc'

Edit the data-science-jhub-values.yaml values file for our jupyter-hub HELM package installation to include the hex string above and the name of the Kuberntes Storage Class.

```yaml
hub:
  uid: 1000
  fsGid: 1000
  concurrentSpawnLimit: 64
  consecutiveFailureLimit: 5
  db:
    pvc:
      accessModes:
        - ReadWriteOnce
      storage: 3Gi
      subPath:
      storageClassName: projectpacific-storage-policy
singleuser:
  image:
    name: jupyter/scipy-notebook
    tag: a95cb64dfe10
  memory:
    limit: 5G
    guarantee: 3.5G
  storage:
    type: dynamic
    dynamic:
      storageClass: projectpacific-storage-policy
  lifecycleHooks:
    postStart:
      exec:
        command: ["/usr/bin/git", "clone", "https://github.com/tkrausjr/data-science-demos.git", "finance-analysis"]
proxy:
  secretToken: "c46350ed823f9433312d110bf39700a765ee3cbc08f0220dff86cc63a570d3be"
```
    
* We will deploy Jupyter Hub components in a separate jupyter namespace.  Let's create the namespace : 

    `kubectl create namespace jupyter`  
    
* Install Jupyter Hub using helm chart and reference the values.yml

    `helm install jhub-pacific jupyterhub/jupyterhub --values data-science-jhub-values.yaml --timeout 210s --namespace jupyter`  
    
    
## Jupyter Hub Validation

To verify your Jupyter deployment is successful, following Kubernetes objects must be running:

```
kubectl get all -n jupyter
    NAME                         READY   STATUS    RESTARTS   AGE
    pod/hub-66956df448-tggfz     1/1     Running   0          94s
    pod/proxy-66dc699669-nlsmc   1/1     Running   0          109s
     
    NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP               PORT(S)        AGE
    service/hub            ClusterIP      10.100.200.232   <none>                    8081/TCP       3m14s
    service/kubernetes     ClusterIP      10.100.200.1     <none>                    443/TCP        6h8m
    service/proxy-api      ClusterIP      10.100.200.45    <none>                    8001/TCP       3m14s
    service/proxy-public   LoadBalancer   10.100.200.169   10.51.0.68,100.64.32.15   80:32562/TCP   3m14s
     
    NAME                    DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/hub     1         1         1            1           3m14s
    deployment.apps/proxy   1         1         1            1           3m14s
    
    NAME                               DESIRED   CURRENT   READY   AGE
    replicaset.apps/hub-66956df448     1         1         1       94s
    replicaset.apps/hub-6f98d5448d     0         0         0       3m14s
    replicaset.apps/proxy-66dc699669   1         1         1       109s
    replicaset.apps/proxy-8669976748   0         0         0       3m14s
```
**Note**:  Each time someone accesses the Jupyter Hub Web page, an additional POD will be instantiated for that user.

**Note**:  Jupyter Hub Proxy Server will have an External IP for the Service.

* To use JupyterHub, enter the external IP for the proxy-public service in to a browser. you You can access the Jupyter Hub UI using http://10.51.0.68.  JupyterHub is running with a default dummy authenticator so entering any username and password combination will let you enter the hub.

* To access the newer JupyterLab UI you can use http://10.51.0.68   on port 80.

* Login with user admin and any password or blank.

*  Open the / finance-analysis / jupyter-hub   folder
    1. Open the ml-stock-predictor-knn-v4
        1. Menu —>  Cell —> RUN ALL 
    2. Open the industry-revenue-analysis
        1. Menu —>  Cell —> RUN ALL 
 

