#!/bin/bash

set -u
set -o pipefail


echo 'DOING LOOP'
while getopts 'p:u:d' arg; do
  echo " in liipo"
  case  '$arg' in
  p | P) 
    echo "PASSWORD"
    PASSWORD=$OPTARG
    exit 0	
    ;;
  u) 
    echo "USERNAME=${OPTARG}"
    exit 0
    ;;
  d)
    echo "tesT"
    ;;
  esac
done
echo "lopp done"


cd $HOME/fabric-ca/server
echo " pass is $PASSWORD with usr $USERNAME"
 

fabric-ca-server  init  -b admin:password

cd $HOME
