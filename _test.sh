#!/bin/sh

set -e

docker kill osmos || echo "Not running"
docker rm -v osmos || echo "Not container"
docker rmi dockosmos || echo "No image"
docker build -t dockosmos .
docker run -d --name osmos dockosmos

time docker exec osmos /root/dl.sh dl-europe import select

