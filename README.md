# jenkins-agent-nodejs

Build and setup Jenkins agent Docker image with Node.js installed and Docker mounted from host machine.

## Prerequisite
- Ubuntu 16.04 LTS (Xenial Xerus)
- Docker version 17.12.0-ce

## Jenkins Master

### Pull Jenkins image
```
docker pull jenkins/jenkins:lts
```

### Start Jenkins
```
docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
```

### Set IP Address

1. Go to `Manage Jenkins` -> `Configure System` -> `Jenkins Location` -> `Jenkins URL`

    Example: `http://172.17.0.1:8080/`

### Make sure JNLP agents port is set

1. Go to `Manage Jenkins` -> `Configure Global Security` -> `Agents`
2. Set `TCP port for JNLP agents` to `Fixed` with port `50000`

### Setup agent node

1. Go to `Manage Jenkins` -> `Manage Nodes` -> `New Node`
2. Select `Permanent Agent`
3. Set `Remote root directory` to `/home/jenkins`
4. Set `Launch method` to `Launch agent via Java Web Start`
5. Note the `secret` and `agent name`

## Jenkins Agent

### Build the Jenkins agent image
```
docker build -t jenkins-agent:latest .
```

### Start the Jenkins agent with Docker mounted from host machine
```
docker run \
    -v $(which docker):/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/lib/x86_64-linux-gnu/libltdl.so.7:/usr/lib/libltdl.so.7 \
    jenkins-agent:latest -url http://172.17.0.1:8080 <secret> <agent name>
```
