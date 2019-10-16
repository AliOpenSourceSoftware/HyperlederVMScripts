#!/bin/bash
echo "test"
name=""
domain=""
ip4=""
name=${HOSTNAME}
domain=${DOMAINNAME}
ip4=${IP4}
if  [ "$HOSTNAME" ]; then
 echo  " Found IP4 environment variabe"
else
  echo "  IPV$ not saved "
  IP4=$(ip route get 8.8.8.8 | awk {'print $7'})
  echo "IP4 .. adding to path"
  sudo chown workstation /etc/profile
  sudo echo "export IPV4=${ip4}" >> /etc/profile
   echo "IP4 added to path "
  sudo chown root /etc/profile
fi

function SetupHostname(){
  echo "Please enter your hostname :"
  read -e hname
  sudo chown workstation /etc/sysctl.conf
  sudo echo  "## Hostname " >> /etc/sysctl.conf
  sudo echo  "kernel.hostname=${hname}" >> /etc/sysctl.conf
  sudo chown root /etc/sysctl.conf
  sudo chown workstation  /etc/hostname
  sudo rm -f /etc/hostname
  sudo touch /etc/hostname
  sudo echo "${hname}" >> /etc/hostname
}

SetupHostname
function SetupDomain(){
if [ "$domainname" ]; then
  echo "Domain name found"
else
  echo "No Domainnae  found"
  read -p "Would you like to add a Domain Name now ?? [y/n]" ans
  case $ans in
    y | Y )
      echo "Please enter the Domain Name"
      read -e dname
	case $dname in
	* )
      sudo chown workstation /etc/sysctl.conf
      sudo echo >> /etc/sysctl.conf
      sudo echo "## Domain name" >> /etc/sysctl.conf
      sudo echo "kernel.domainname=$dname" >> /etc/sysctl.conf
      sudo chown root /etc/sysctl.conf
      echo "Added Domain to  sysctl.conf"
      ## sudo hostnamectl set-hostname "${dname}"
      ## sudo service hostname restart
;;
esac
;;
    n | N ) return ;;
    * ) SetupDomain ;;
  esac
fi
}


SetupDomain



TEMP_PORT=0
function EnvSetup(){
  echo "Checking and configureing environment"
  FABRIC_CA_SERVER_HOME="${FABRIC_CA_SERVER_HOME:-$HOME/fabric-ca/server}"

  echo "server home -> " ${FABRIC_CA_SERVER_HOME}
  echo "server listen port -> "${FABRIC_CA_SERVER_LISTEN_PORT}
  echo "Done environment setup ... "

}
