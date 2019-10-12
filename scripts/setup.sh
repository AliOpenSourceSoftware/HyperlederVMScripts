#!/bin/bash

cd /home/workstation
echo Creating Directpry St
mkdir go
mkdir go/src
mkdir go/src/github.com
mkdir go/src/github.com/hyperledger
mkdir go/src/github.com/workstation
cd Downloads
su
apt-get update
apt-get upgrade 
apt install curl
apt install docker
apt install docker-compose
systemctl enable docker
systemctl start docker

usermod -aG docker workstation