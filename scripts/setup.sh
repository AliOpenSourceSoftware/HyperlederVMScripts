#!/bin/bash

cd /home/workstation
echo ------------------- Creating Directory Structure ----------------------
mkdir go
mkdir go/src
mkdir go/src/github.com
mkdir go/src/github.com/hyperledger
mkdir go/src/github.com/workstation
echo-------------- Moving into root to update and upgrade ------------------
su
apt-get update
apt-get upgrade 
echo ----------------Instaling curl---------------------
apt install -y curl
echo ----------------Instaling DOCKER and DOCKER-COMPOSE---------------------
apt install -y docker
apt install -y docker-compose
systemctl enable docker
systemctl start docker

usermod -aG docker workstation
cd Downloads
echo ------------------- INSTALLING GO -------------------------------
wget https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz
tar -xvf  go1.13.1.linux-amd64.tar.gz /usr/local/go
rm go1.13.1.linux-amd64.tar.gz
echo --------------------- setting go path and root ----------------------

echo "export WORKSTATION=/home/workstation/go/src/github.com/workstation" >> /etc/profile
echo "export HYPERLEDGER=/home/workstation/go/src/github.com/hyperledger" >> /etc/profile
echo "export FABRIC=/home/workstation/go/src/github.com/hyperledger/fabric" >> /etc/profile
echo "export FABRICSAMPLES=/home/workstation/go/src/github.com/hyperledger/fabric/fabric/samples" >> /etc/profile
echo "export GOROOT=/usr/local/go" >> /etc/profile
echo "export GOPATH=/home/workstation/go" >> /etc/profile
echo "export PATH=/usr/local/go/bin:/home/workstation/go/bin:$PATH" >> /etc/profile
nano /etc/profile

exit
cd $HYPERLEDGER/fabric/scripts
./bootstrap.sh
cd $WORKSTATION/fabric-samples/first-network
./byfn.sh up




