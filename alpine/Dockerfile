FROM jenkinsci/jnlp-slave:alpine

USER root

RUN apk add --update sudo git nodejs yarn && \
    yarn global add typescript

RUN echo "jenkins ALL=NOPASSWD: /usr/bin/docker" >> /etc/sudoers

USER jenkins

ENV PATH="/home/jenkins/scripts:$PATH"

COPY scripts/docker.sh /home/jenkins/scripts/docker