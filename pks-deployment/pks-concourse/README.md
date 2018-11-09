
Pre-requisites
Make sure your Concourse Docker Containers are still running, using docker ps to check that the following 5 Containers are running.
        1. concourse/concourse:3.14.1   "/usr/local/bin/du..."   3 minutes ago       Up 3 minutes                                 concourse_concourse-worker_1
        2. concourse/concourse:3.14.1   "/usr/local/bin/du..."   3 minutes ago       Up 3 minutes        0.0.0.0:8080->8080/tcp   concourse_concourse-web_1
        3. postgres                     "docker-entrypoint..."   3 minutes ago       Up 3 minutes        5432/tcp                 concourse_concourse-db_1
        4. nginx                        "nginx -g 'daemon ..."   3 minutes ago       Up 3 minutes        0.0.0.0:40001->80/tcp    nginx-server
        5. nsx-t-install                "/home/run.sh"           3 minutes ago       Up 3 minutes                                 nsx-t-install


FROM an UBUNTU Jumpbox - 110.371.13.90
1. mkdir -p /root/pks
2. cd /root/pks 
2. /root/pks $ wget https://github.com/sparameswaran/nsx-t-ci-pipeline/blob/master/pipelines/install-pks-pipeline.yml .
3. /root/pks $ wget https://github.com/sparameswaran/nsx-t-ci-pipeline/blob/master/pipelines/install-pks-pipeline.yml .

