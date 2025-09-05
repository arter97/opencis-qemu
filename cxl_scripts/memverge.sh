#!/bin/bash

if [ $# -eq 0 ]
then
    SOCKET_HOST=0.0.0.0
else
    SOCKET_HOST=$1
fi
echo "SOCKET_HOST IS $SOCKET_HOST"

cd /home/arter97/lab/opencis/memverge/qemu/build
./qemu-system-x86_64 \
	-m 4G,slots=4,maxmem=8G -smp 4 \
	-machine type=q35,cxl=on -nographic \
	-hda /home/arter97/lab/opencis/images/ubuntu-noble1.qcow2 \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-ram,id=mem0,size=4G \
-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
	-nic user,id=vmnic,hostfwd=tcp::2223-:22
