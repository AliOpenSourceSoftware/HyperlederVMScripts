sudo mkdir -p /opt/hyperledger/fabric-1.14

cd $WORKSTATION/fabric
git checkout release-1.14
make clean release
sudo cp -r release/linux-amd64/bin /opt/hyperledger/fabric-1.14 

cd $WORKSTATION/fabric-ca
make clean release fabric-ca-server
sudo cp -r bin/* /opt/hyperledger/fabric-1.14/bin/
sudo cp -r release/linux-amd64/bin /opt/hyperledger/fabric-1.14
sudo chown  workstation /etc/profile
sudo echo "export PATH=/opt/hyperledger/fabric-1.14/bin:${PATH} " >> /etc/profile
sudo chown root /etc/profile
source /etc/profile
