#!/bin/bash
set -e

# Use full path for volumes
ROOTPATH="$1"
[ -z "$ROOTPATH" ] && echo "usage: $0 ROOTPATH" && exit 1

# Path on the host
DB=$ROOTPATH/volumedb
DL=$ROOTPATH/volumedl

# Mount path in the container
DBMOUNT=/var/lib/postgresql/data
DLMOUNT=/dl
OSM_ROOT_DIR=$DL

mkdir -p $DL
# Remove database directory
sudo rm -rf $DB
mkdir -p $DB

docker volume rm volumedb || echo "No volume"
docker kill osmos || echo "Not running"
docker rm -v osmos || echo "No container"
docker rmi dockosmos || echo "No image"
docker build -t dockosmos .

OPTIONS=" -e OSM_ROOT_DIR=$DLMOUNT"
OPTIONS+=" -v $DL:$DLMOUNT"
# Use a work directory because docker creates file with restricted permissions
OPTIONS+=" -v $DB:$DBMOUNT"
OPTIONS+=" -d --name osmos"
docker run $OPTIONS dockosmos

time docker exec osmos /root/dl.sh dl import select
