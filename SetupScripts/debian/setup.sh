#!/bin/bash
cd /home/workstation

sudo apt install -y curl
sudo apt install -y docker
sudo apt install -y docker-compose
usermode -aG docker workstation
sudo systemctl enable docker
sudo systemctl start docker
mkdir -p go/src/github.com/hyperledger
mkdir -p go/src/github.com/workstation
cd  $HOME/Downloads
wget https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz
tar -xvf go1.13.1.linux-amd64.tar.gz
sudo mv go  /usr/local/go1.13.1
sudo chown workstation /etc/profile
sudo echo "export GOROOT=/usr/local/go1.13.1" >> /etc/profile
sudo echo "export GOPATH=/home/workstation/go" >> /etc/profile
source /etc/profile
sudo echo "export PATH=${GOROOT}/bin:${GOPATH/bin}:${PATH}" >> /etc/profile
sudo echo "export WORKSTATION=/home/workstation/go/src/github.com/workstation" >> /etc/profile
sudo echo "export HYPERLEDGER=/home/workstation/go/src/github.com/hyperledger" >> /etc/profile
sudo echo "export FABRIC=/home/workstation/go/src/github.com/hyperledger/fabric" >> /etc/profile
source /etc/profile
chown root /etc/profile
cd $HYPERLEDGER
git clone https://github.com/hyperledger/fabric.git
git clone https://github.com/hyperledger/fabric-ca.git
git clone https://github.com/hyperledger/fabric-samples
cp -r *  $WORKSTATION
cd /home/workstation/Downloads
rm -rf *


cd $FABRIC/scripts
./bootstrap.sh


