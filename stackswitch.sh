#!/bin/bash

SERV="libvirt-bin
nova-network
nova-compute
nova-cert
nova-api
nova-scheduler
nova-consoleauth
nova-console
cinder-volume
cinder-api
cinder-scheduler
tgtd"
#nova-objectstore
#novnc
#nova-volume

if [ "$1" == "stop" ] || [ "$1" == "start" ] || [ "$1" == "restart" ] || [ "$1" == "status" ]; then
	for a in $SERV;
	do service "$a" $1;
	done
else
	echo "expected: stackswitch { start | stop | restart | status }"
fi

