FROM jenkinsci/jnlp-slave

USER root

RUN apt-get update && \
    apt-get install -y sudo git && \
    echo "jenkins ALL=NOPASSWD: /usr/bin/docker" >> /etc/sudoers

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g typescript yarn && \
    chown -R jenkins:jenkins /home/jenkins/.config && \
    chown -R jenkins:jenkins /home/jenkins/.npm

USER jenkins

RUN mkdir -p /home/jenkins/scripts

ENV PATH="/home/jenkins/scripts:$PATH"

COPY scripts/docker.sh /home/jenkins/scripts/docker