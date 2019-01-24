
## Reference
Based on https://github.com/sparameswaran/nsx-t-ci-pipeline

## Prereqs
Make sure your Concourse Docker Containers are still running, using docker ps to check that the following 5 Containers are running.
 * concourse/concourse:3.14.1 "/usr/local/bin/du..." 3 minutes ago Up 3 minutes concourse_concourse-worker_1
  * concourse/concourse:3.14.1 "/usr/local/bin/du..." 3 minutes ago Up 3 minutes 0.0.0.0:8080->8080/tcp concourse_concourse-web_1
  * postgres "docker-entrypoint..." 3 minutes ago Up 3 minutes 5432/tcp concourse_concourse-db_1
  * nginx "nginx -g 'daemon ..." 3 minutes ago Up 3 minutes 0.0.0.0:40001->80/tcp nginx-server
  * nsx-t-install "/home/run.sh" 3 minutes ago Up 3 minutes nsx-t-install

## Install Instructions for PKS 1.3 or higher
1. mkdir -p /root/pks
2. cd /root/pks 
  * NOTE: You must get Nathans pipeline (install-pks-pipeline.yml) as Sabhas no longer works on PKS 1.3
2. /root/pks $ wget https://raw.githubusercontent.com/nvpnathan/nsx-t-ci-pipeline/master/pipelines/install-pks-pipeline.yml
3. /root/pks $ cd .. 
4. /root/pks $ wget https://raw.githubusercontent.com/tkrausjr/k8s-manifests/master/pks-deployment/pks-concourse/tk-pks-params-v4.yml  /root/tk-pks-params-v5.yml
4. /root/pks $ vi tk-pks-params-v5.yml
5. /root $ fly targets
6.  fly --target main login --concourse-url http://10.173.13.90:8080
7. /root/pks $  fly --target main set-pipeline -p pks-pipeline-nathan-v5 -c $PWD/install-pks-pipeline.yml -l /root/tk-pks-params-v5.yml
  * apply configuration [yN]: y
  * Hit YES
8. In a browser, navigate to http://10.173.13.90:8080 (Concourse) and login to Main.
9. Click hamburger Menu in Top Left to show both pipelines
10. Unpause pks-pipeline



## Install Instructions for PKS 1.2 or lower
1. mkdir -p /root/pks
2. cd /root/pks 
2. /root/pks $ wget https://raw.githubusercontent.com/sparameswaran/nsx-t-ci-pipeline/master/pipelines/install-pks-pipeline.yml .
3. /root/pks $ wget https://raw.githubusercontent.com/tkrausjr/k8s-manifests/master/pks-deployment/pks-concourse/tk-pks-params-v4.yml .
4. /root/pks $ vim tk-pks-params-v4.yml
5. /root/pks $ fly targets
6.  fly --target main login --concourse-url http://10.173.13.90:8080
7. /root/pks $  fly --target main set-pipeline -p pks-pipeline -c /root/pks/install-pks-pipeline.yml -l /root/pks/tk-pks-params-v4.yml
  * apply configuration [yN]: y
  * Hit YES
8. In a browser, navigate to http://10.173.13.90:8080 (Concourse) and login to Main.
9. Click hamburger Menu in Top Left to show both pipelines
10. Unpause pks-pipeline



