\##################################################################
#                            HyperledgerVMS                      #
#                        HyperledgerVMs.appspot.com              #
##################################################################
# setup.sh                                                       #
#     this scripts will auto install hyperledger fabrics various #
#     components on linux debian                                 #
##################################################################
#  Created by		: Aaron Ali				 #
#  Email		: aaronali@email.com			 #
#  Created On		: 2019-10-19				 #
#  Last update		: 2019-10-19				 #
##################################################################

#!/bin/bash
cd /tmp

apt install -y curl
apt install -y git
apt install -y gcc
apt install -y make
apt install -y sudo
apt install -y dnsutils
apt install -y docker
apt install -y docker-compose
apt install -y ssh
echo " **************************"
echo " Starting services"
echo " **************************"
systemctl start ssh
systemctl unmask docker.service
systemctl unmask docker.socket
systemctl unmask docker
systemctl start docker.service
systemctl start docker.socket
systemctl start docker
echo "Enable docker on start up ? [ Y | * / no]"
read ans1 -p
case $ans1 in
 y | Y )
  systemctl enable docker
  ;;
esac

echo "Enable ssh on start uo [ Y | * / no ]"
read ans2 -p
case $ans2 in
y | Y )
  systemctl enable ssh
  ;;
esac

wget "https://dl.google.com/go/go1.13.1.linux-amd64.tar.gz"
tar -xvf go1.13.1.linux-amd64.tar.gz
mv go /usr/lib/go1.13.1
echo "export GOROOT=/usr/lib/go1.13.1" >> /etc/profile
export GOROOT=/usr/lib/go1.13.1
cp -r /usr/lib/go1.13.1/bin/*  /usr/bin

mkdir -p  go/src/github.com/hyperledger
cd go/src/github.com/hyperledger
git clone https://github.com/hyperledger/fabric-ca.git
export GOPATH=/tmp/go
git clone https://github.com/hyperledger/fabric.git
git clone https://github.com/hyperledger/fabric-cli.git

cd fabric


git checkout release-1.4
make release
echo " ********************************"
echo " Verify fabric release  build then continue "
read ans3  -p

cd ../fabric-ca
git checkout release-1.4
make fabric-ca-server
echo " *********************************"
echo " Verify fabric-ca-server "
read ans4 -p
make fabric-ca-client
echo " *********************************"
echo " Verify fabric-ca-client build "
read ans5 -p
cd ../fabric-cli
make
echo " *********************************"
echo " Verify fabric-cli build          "

read ans6 -p

mkdir -p /usr/lib/hyperledger/fabric/release-1.4
mkdir -p /usr/lib/hyperledger/fabric-ca/release-1.4
mkdir -p /usr/lib/hyperledger/fabric-cli

cp -r /tmp/go/src/github.com/hyperledger/fabric/release/linux-amd64/  /usr/lib/hyperledger/fabric/release-1.4
cp -r /tmp/go/src/github.com/hyperledger/fabric-ca/bin  /usr/lib/hyperledger/fabric-ca/release-1.4
cp -r /tmp/go/src/github.com/hyperledger/fabric-cli/bin  /usr/lib/hyperledger/fabric-cli

ln -s /usr/lib/hyperledger/fabric/release-1.4/bin /usr/lib/hyperledger/fabric/bin
ln -s /usr/lib/hyperledger/fabric-ca/release-1.4/bin /usr/lib/hyperledger/fabric-ca/bin

chmod +x /usr/lib/hyperledger/fabric/bin/
chmod +x /usr/lib/hyperledger/fabric-ca/bin/
chmod +x /usr/lib/hyperledger/fabric-cli/bin/

echo "## HYPERLEDGER PATHS"
echo "export PATH=/usr/lib/hyperledger/fabric/bin:${PATH}" >> /etc/profile
echo "export PATH=/usr/lib/hyperledger/fabric-ca/bin:${PATH}" >> /etc/profile
echo "export PATH=/usr/lib/hyperledger/fabric-cli/bin:${PATH}" >> /etc/profile
echo "export FABRIC_CA_SERVER_HOME=/home/hyperledger/fabric-ca/server" >> /etc/profile
echo "export FABRIC_CA_CLIENT_HOME=/home/hyperledger/fabric-ca/client" >> /etc/profile
echo "export FABRIC_CFG_PATH=/home/hyperledger/config" >> /etc/profile
source /etc/profile
mkdir -p $FABRIC_CA_SERVER_HOME
chown -R workstation:workstation /home/hyperledger/
mkdir -p $FABRIC_CA_CLIENT_HOME
mkdir -p $FABRIC_CFG_PATH

usermod -aG sudo workstation
usermod -aG docker workstation


