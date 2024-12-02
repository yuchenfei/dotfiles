#!/bin/bash

target_ip="192.168.100.254"

if ping -c 1 -W 1 $target_ip &> /dev/null; then
    echo "home"
else
    echo "not_home"
fi
