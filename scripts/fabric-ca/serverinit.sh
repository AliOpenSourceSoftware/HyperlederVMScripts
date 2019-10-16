#####################################################################################
##                                   HyperledgerVMs                                ##
##                             HyperledgerVMs.appspot.com                          ##
##                                                                                 ##
#####################################################################################
##  Author     : Aaron Ali                                                         ##
##  Email      : aaronali@email.com                                                ##
##  Created    : 2019-10-15                                                        ##
##  LastUpdate : 2019-10-15                                                        ##
#####################################################################################

#!/bin/bash

function Usage() {
  echo " Usage : .  serverinit.sh  -u <adminusername> -p <adminpassword>  <options>"
  echo "    -c <channel name> - channel name to use (defaults to \"mychannel\")"
  echo "    -u admin username - defaults to $USERNAME"
  echo "    -p admin password - defaults to \"PASSWORD\""
  echo "    --tls.disabled  Disable TLS on listening port (Always enabled by default)"
  echo "    -l , --port Listening port"
  echo "    -t <timeout> - CLI timeout duration in seconds (defaults to 10)"
  echo "    -d <delay> - delay duration in seconds (defaults to 3)"
  echo "    -s <dbtype> - the database backend to use: goleveldb (default) or couchdb"
  echo "    -l <language> - the programming language of the chaincode to deploy: go (default), javascript, or java"
  echo "    -i <imagetag> - the tag to be used to launch the network (defaults to \"latest\")"
  echo "    -a - launch certificate authorities (no certificate authorities are launched by default)"
  echo "    -n - do not deploy chaincode (abstore chaincode is deployed by default)"
  echo "    -v - verbose mode"

}

TEMP_PORT=0
function EnvSetup(){
  echo "Checking and configureing environment"
  FABRIC_CA_SERVER_HOME="${FABRIC_CA_SERVER_HOME:-$HOME/fabric-ca/server}"

  echo "server home -> " ${FABRIC_CA_SERVER_HOME}
  echo "server listen port -> "${FABRIC_CA_SERVER_LISTEN_PORT}
  echo "Done environment setup ... "

}

function RemoveCerts(){
  read -p "Would you like to delte the old certificates ? [y/n] " ans
  case $ans in
  y | Y )
    echo "Confirmed deletion of old certificates"
    cd $FABRIC_CA_SERVER_HOME
    rm -f ca-cert.pem
    ;;
  n | N)
    echo "Using pre exisiting certificates"
    ;;
  *)
    RemoveCerts
    ;;
  esac
}
#RemoveCerts

function RemoveDBConfig(){
read -p "Would you like to delete the current db config file? [y/n"] ans
case $ans in
  y | Y)
    echo "Confirmed deletion of old database configuration"
    cd $FABRIC_CA_SERVER_HOME
    rm fabric-ca-server.db
    ;;
  n | N)
    echo "Using existing database configuration"
    ;;
  * )
    RemoveDBConfig
    ;;
  esac
}

#RemoveDBConfig

function RemoveKeys(){
  read -p "Would you like to delete the exisiting key files?? [y/n] " ans
  case $ans in
    y | Y)
      echo "Confirmed deletion of current keys"
      cd $FABRIC_CA_SERVER_HOME
      rm -rf msp
      rm IssuerRevocationPublicKey
      rm IssuerPublicKey
      ;;
    n | N)
      echo "Using existinng keys"
      ;;

    * )
   RemoveKeys
 ;;
esac
}
#RemoveKeys

function PurgeConfigYaml(){
read -p "Would you like to force deletion of the current fabric-ca-server.yaml file ?? [y|n]" ans
case $ans in
y | Y)
  cd  $FABRIC_CA_SERVER_HOME
  rm -f fabric-ca-server-config.yaml
  ;;
n | N)
  echo  "Skipping"
  ;;
* )
 PurgeConfigYaml
 ;;
esac

}
TEMP_TLS=0
#PurgeConfigYaml
OPTIND=1


next=null
for arg in "$@";do


  case $next in
    11) SetPort $arg
        ;;
    15) PASSWORD=$arg
        ;;
    20) USERNAME=$arg
        ;;
    25) CHANNEL_NAME=$arg
  esac
  next=null;


  argcount=$((${argcount}+1))
  case "$arg" in
    "--help" | "-h"  | "help" | "?" | "-?")
      Usage
      return
      ;;
    "--port" | "-l" | "-port")
      next=11
      ;;
    "-p" | "-password" | "--password")
      next=15
      ;;
    "-u" | "-username" | "--username")
      next=20
      ;;
    "-c" | "-channel" | "--channel")
      next=25
      ;;
    "tls.disabled" | "-tls.disabled" | "--tls.disabled")
      TEMP_TLS=1
      ;;
esac

done



function SetPort(){
 echo "serverinit.sh - SetPort()"
 FABRIC_CA_SERVER_LISTEN_PORT=$1
 echo "Server listen port set to  ${FABRIC_CA_SERVER_LISTEN_PORT}"
}





function InitilizeServer(){
 EnvSetup
 cd $FABRIC_CA_SERVER_HOME

echo -e "temp tls = $TEMP_TLS"

case  "$TEMP_TLS" in
0)
  #fabric-ca-server init  -b ${USERNAME}:${PASSWORD} --home "${FABRIC_CA_SERVER_HOME}" -p ${FABRIC_CA_SERVER_LISTEN_PORT} 
  echo "fabric-ca-server init tls.enable -b ${USERNAME}:${PASSWORD} -- \"${FABRIC_CA_SERVER_HOME}\" --port ${FABRIC_CA_SERVER_LISTEN_PORT}"
 echo "*****************************************************" 
 echo "fabric-ca-server is ready to started with TLS enabled"
 echo "******************************************************"
 ;;
1)
  echo fabric-ca-server init -b ${USERNAME}:${PASSWORD} --home "${FABRIC_CA_SERVER_HOME}" -p ${FABRIC_CA_SERVER_LISTEN_PORT}
echo "************************************"
echo "fabric-ca-server started without TLS"
echo "************************************"
  ;;
esac

}



InitilizeServer
