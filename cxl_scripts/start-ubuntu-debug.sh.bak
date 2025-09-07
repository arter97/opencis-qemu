#!/bin/bash

if [ $# -eq 0 ]
then
    SOCKET_HOST=0.0.0.0
else
    SOCKET_HOST=$1
fi
echo "SOCKET_HOST IS $SOCKET_HOST"

#    --trace "kvm_guest_took*"

cd ../build && ./qemu-system-x86_64 \
    --trace "cxl_root*" \
    --trace "cxl_read*" \
    --trace "cxl_write*" \
    --trace "cxl_usp*" \
    --trace "cxl_debug*" \
    --trace "cxl_socket_cxl_io*" \
    --trace "qdev_device*" \
    --trace "pc_debug*" \
    --trace "vl_debug*" \
    --trace "pci_debug*" \
        -D debug.log \
	-m 4G,slots=4,maxmem=8G -smp 1 \
	-machine type=q35,accel=kvm,cxl=on -nographic \
	-hda /home/arter97/lab/opencis/images/ubuntu-noble1.qcow2 \
	-D debug.log \
	-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
	-device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=2,switch-port=0,socket-host=$SOCKET_HOST \
	-M "cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=512G" \
	-nic user,id=vmnic,hostfwd=tcp::2223-:22
