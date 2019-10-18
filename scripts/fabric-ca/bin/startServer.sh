#***************************************************************************#
#*                                 HyoerledgerVMs                          *#
#*                           HyperledgerVMs.appspot.com                    *#
#***************************************************************************#
#* Created By     : Aaron Ali                                              *#
#* Email          : aaronali@email.com                                     *#
#* Date Created   : 2019-10-17                                             *#
#* Last Updated   : 2019-10-17                                             *#
#***************************************************************************#


#!/bin/bash
cd $HOME/fabric-ca/server


function Usage(){
echo "Usage :"
echo " -h        display help and usage "
echo " local    listens on 0.0.0.0"
echo " public   listens on the 1p4 address extracted from the ip4 command"

}

function LaunchLocalServer(){
  cd $FABRIC_CA_SERVER_HOME
  fabric-ca-server start  --address 127.0.0.1
}

function LaunchPublicServer(){
  echo "Local"
}

for arg in "$@"; do

 case $arg in
    -h | h | \? | --h | -help |--help )
     Usage
     return
     ;;
    "local" )
       #LaunchLocalServer
       address=127.0.0.1
       ;;
     "public" )
       address=$(ip4)
       ;;
    * ) 
      echo "Unknown  argument $arg"
      Usage
      return
 esac
done

fabric-ca-server start --address $address
