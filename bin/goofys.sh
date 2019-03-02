#!/bin/bash
# Mount goofys into specific location with catfs

set -e

if [[ ! -x `which goofys` || ! -x `which catfs` ]]; then
    echo "Please install goofys and catfs first."
    echo "goofys -> https://github.com/kahing/goofys/"
    echo "catfs -> https://github.com/kahing/catfs/"
    exit 1
fi

BUCKET=$1
POINT=$2
uid=$(id -u)
gid=$(id -g)

mkdir -p $HOME/.cache/goofys

goofys --uid $uid --gid $gid --cache "--free:10%:$HOME/.cache/goofys" -o allow_other $BUCKET $POINT

echo "Mounting S3 bucket with goofys successful. Use fusermount -u <mount point> if you want to unmount."
