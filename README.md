# poc-sim-deployment-automation
This project contains code related to Helm, Tekton and Jenkins POC for SIM deployment automation.

# https://github.com/jenkinsci/docker/blob/master/README.md
docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts
docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts

# Volumne permision for bind mount (volumen on host machine)
# https://stackoverflow.com/questions/44065827/jenkins-wrong-volume-permissions


docker build -t custom_jenkins .
docker run -p 8080:8080 -p 50000:50000 -v /c/Users/AtulChauhan/docker_jenkins_data:/var/jenkins_home custom_jenkins -u root

# Sample docker-compose file
https://raw.githubusercontent.com/bitnami/bitnami-docker-jenkins/master/docker-compose.yml