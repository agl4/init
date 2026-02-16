#!/bin/sh
set -euxv
date=$(date --iso-8601=minutes)
num=$(sudo snapper create --type pre --description "DUP $date" --userdata important=yes --print-number)
if [ -z "$num" ] ; then
	exit 1
fi
sudo zypper dup
sudo zypper ref
sudo zypper up
sudo snapper create --type post --pre-number "$num" --description "DUP $date" --cleanup-algorithm number --userdata important=yes
