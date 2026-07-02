#!/usr/bin/env bash
set -eu

FILENAME=
LUKSNAME=
SIZE=1024
CIPHER=serpent-xts-plain64
ITER_TIME=5000

while getopts i:s:l:f:c: options
do
    case $options in
        i) ITER_TIME=$OPTARG ;;
        s) SIZE="$OPTARG" ;;
        f) FILENAME="$OPTARG" ;;
        l) LUKSNAME="$OPTARG" ;;
        c)
            case $OPTARG in
                aes-xts-plain64) CIPHER=aes-xts-plain64 ;;
                serpent-xts-plain64) CIPHER=serpent-xts-plain64 ;;
                twofish-xts-plain64) CIPHER=twofish-xts-plain64 ;;
                *)
                    echo "Invalid CIPHER: $OPTARG"
                    exit 1
                    ;;
            esac
            ;;
    esac
done

mount_root=/run/media

LUKSNAME=${LUKSNAME:="$(basename ${FILENAME})"}

if [ -z "$FILENAME" ] ; then
    echo "Missing option -f FILENAME"
    exit 1
fi

if [ -e "$FILENAME" ] ; then
    udisksctl loop-setup -f "${FILENAME}"
else
    dd if=/dev/random of="${FILENAME}" status=progress bs=1M count="${SIZE}"
    sudo cryptsetup --debug -vy luksFormat "$FILENAME" --type luks2 --cipher "$CIPHER" --key-size 512 --hash sha512 --iter-time "$ITER_TIME" --use-random
    sudo cryptsetup luksOpen "$FILENAME" "$LUKSNAME"
    sudo mkfs.ext4 -m 0 -L "$FILENAME" "/dev/mapper/${FILENAME}"
    sudo cryptsetup luksClose "$LUKSNAME"
    udisksctl loop-setup -f "${FILENAME}"
fi

echo $FILENAME
