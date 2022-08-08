#! /bin/bash
apt update
apt install docker.io -y
docker run -d -p 8080:80 wordpress