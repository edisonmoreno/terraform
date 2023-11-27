#!/bin/bash
sudo yum install docker -y
sudo service docker start
sudo docker run -d -p 8080:8021 edisonmorenoco/ms-move-admin:latest