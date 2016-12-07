#!/bin/bash

set -e

# Use full path for volumes
ROOTPATH=$1
[ -z "$ROOTPATH" ] && ROOTPATH=$(pwd)

# Path on the host
DB=$ROOTPATH/volumedb
DL=$ROOTPATH/volumedl

# Mount path in the container
DBMOUNT=/var/lib/postgresql/data
DLMOUNT=/dl
OSM_ROOT_DIR=$DL

mkdir -p $DB
mkdir -p $DL

docker kill osmos || echo "Not running"
docker rm -v osmos || echo "Not container"
docker rmi dockosmos || echo "No image"
docker build -t dockosmos .

OPTIONS=" -e OSM_ROOT_DIR=$DLMOUNT"
OPTIONS+=" -v $DB:$DBMOUNT"
OPTIONS+=" -v $DL:$DLMOUNT"
OPTIONS+=" -d --name osmos"
docker run $OPTIONS dockosmos

time docker exec osmos /root/dl.sh dl import select

