#!/bin/sh

if [ "x$(echo $1 | grep -c 'http://')" == "x1" ]; then
    wget "$1" -O "/root/install.swu"
    install_path="/root/install.swu"
else
    install_path="$1"
fi

if [ -e "${install_path}" ]; then
    _cur_mmcpart=$(basename $(findmnt / -o SOURCE -n ))
    if [ "$_cur_mmcpart" == "mmcblk1p3" ]; then
        # Current bank is B, install to A
        _partno=A
    else
        # Current bank is A, install to B
        _partno=B
    fi

    swupdate -v -e stable,rootfs${_partno} -H coral-dev:1.0 -f /etc/swupdate.cfg -i ${install_path} && reboot
else
    echo "Failed to locate image: $1"
fi