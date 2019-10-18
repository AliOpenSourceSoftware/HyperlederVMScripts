#***************************************************************************#
#*                               HyperledgerVMs                            *#
#*                            HyperledgerVMs.appspot.com                   *#
#***************************************************************************#
#* Created by    : Aaron Ali                                               *#
#* Email         : aaronali@email.com                                      *#
#* Date Created  : 2019-10-07                                              *#
#* Last Update   : 2019-10-07                                              *#
#***************************************************************************#


if [ $FABRIC_CA_SERVER_LISTEN_PORT ] ;then
port=$FABRIC_CA_SERVER_LISTEN_PORT
else
port=705
fi

function Usage(){
 echo "Usage :"
 echo "  start  <options> -u <usernam> -p <password> "
}

next=0
tls=0

for arg in "$@"; do

 case $next in
  1 )
	address=$arg
	;;
  2 )
	password=$arg
	;;
  3 )
	username=$arg
	;;
  4 )
	port=$arg
	;;
esac


if [ $next = 0 ]; then
 case $arg in
  "-tls.disabled" |  "--tls.disabled")
     tls=1
     ;;
  "-address" | "--address" )
     next=1
     ;;
   "-local" | "--local" )
     address=127.0.0.1
     ;;
   "-p" | "--p" )
     next=2
     ;;
   "-u" | "--u" )
     next=3
     ;;
   "-port" | "--port")
     next=4
     ;;
    * )
    echo "Unknown argument $arg"
    Usage
    return
    ;;
  esac
else
next=0
fi
done


if [ $tls = 0 ]; then
fabric-ca-client enroll -u https://$username:$password@$address:$port
else
fabric-ca-client enroll -u http://$username:$password@$address:$port
fi
