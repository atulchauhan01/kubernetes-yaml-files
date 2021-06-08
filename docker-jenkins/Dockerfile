FROM jenkins/jenkins:lts
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

RUN uname -a && cat /etc/*release

#install docker CLI
ENV DOCKERVERSION=19.03.13
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz


# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl;
RUN chmod +x ./kubectl;
RUN mv ./kubectl /usr/local/bin/kubectl



# RUN curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

# RUN apt-get update \
#      && apt-get install -y sudo \
#      && rm -rf /var/lib/apt/lists/*

RUN usermod -a -G root jenkins
# RUN usermod -a -G docker jenkins

# Good idea to switch back to the jenkins user.
# USER jenkins