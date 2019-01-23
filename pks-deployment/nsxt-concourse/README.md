#### REFERENCE https://github.com/vmware/nsx-t-datacenter-ci-pipelines

#### FOR Cleaning up a previous NSX-T Environment see bottom of this NOTE:

## FROM an UBUNTU Jumpbox - 110.371.13.90

1. wget https://github.com/vmware/nsx-t-datacenter-ci-pipelines/raw/master/docker_image/nsx-t-install-09122018.tar -O nsx-t-install.tar
2. docker load -i nsx-t-install.tar
3. TEST - docker images | grep nsx
4. mkdir -p /home/concourse
5. Download NSX Manager 2.3.0 to /home/concourse
nsx-unified-appliance-2.3.0.0.0.10085405.ova NOTE: I did this from windows jump box and WINSCP over to Linux Jumpbox.
6. Download OVFTOOL 4.x to /home/concourse
https://my.vmware.com/group/vmware/details?downloadGroup=OVFTOOL430&productId=742
7. Edit Parameters file ( nsx_pipeline_config.yml )(make a copy) to fit customers environment.
8. Put parameters file ( nsx_pipeline_config.yml ) into /home/concourse
DONT Rename his file.
Make sure you uncomment out the following lines and put the correct file names from Step 5 & 6 above.
ova_file_name: "nsx-unified-appliance-2.3.0.0.0.10085405.ova" #Uncomment this if downloaded file manually and placed under /home/concourse
ovftool_file_name: "VMware-ovftool-4.3.0-10104578-lin.x86_64.bundle" #Uncomment this if downloaded file manually and placed under /home/concourse
9. Now run the following command to start the docker container which will run docker-compose and spin up multiple containers including nginx and concourse worker and web.
docker run --name nsx-t-install -d -v /var/run/docker.sock:/var/run/docker.sock -v /home/concourse:/home/concourse -e CONCOURSE_URL="http://110.371.13.90:8080" -e EXTERNAL_DNS="110.371.13.90" -e IMAGE_WEBSERVER_PORT=40001 nsx-t-install

When finished use docker ps to check that the following 5 Containers are running.
concourse/concourse:3.14.1 "/usr/local/bin/du..." 3 minutes ago Up 3 minutes concourse_concourse-worker_1
concourse/concourse:3.14.1 "/usr/local/bin/du..." 3 minutes ago Up 3 minutes 0.0.0.0:8080->8080/tcp concourse_concourse-web_1
postgres "docker-entrypoint..." 3 minutes ago Up 3 minutes 5432/tcp concourse_concourse-db_1
nginx "nginx -g 'daemon ..." 3 minutes ago Up 3 minutes 0.0.0.0:40001->80/tcp nginx-server
nsx-t-install "/home/run.sh" 3 minutes ago Up 3 minutes nsx-t-install

10. In a browser, navigate to http://110.371.13.90:8080 and Start the pipeline

## To restart the pipeline
If pipeline fails and needs to be rerun, you will need to start over and clean up Docker containers.
```docker rm -f $(docker ps -qa)
docker system prune
cd /home/concourse && rm -rf keys/ docker-compose.yml pipeline_config_internal.yml generate-keys.sh
Rerun the command
docker run --name nsx-t-install -d -v /var/run/docker.sock:/var/run/docker.sock -v /home/concourse:/home/concourse -e CONCOURSE_URL="http://110.371.13.90:8080" -e EXTERNAL_DNS="110.371.13.90" -e IMAGE_WEBSERVER_PORT=40001 nsx-t-install```

You will also need to delete the NSX-T Virtual Machines (Manager, Controller, Edges) and unregister the vSphere extension.

https://vcenter-fqdn.domain.com/mob
Login with VC Creds
 - Content
 - ExtensionManager
 - extensionList["com.vmware.nsx.management.nsxt"]	
 - UnregisterExtension
 - Paste "com.vmware.nsx.management.nsxt"
 - Invoke Method.
 

