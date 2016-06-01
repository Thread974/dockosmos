docker kill osmos
docker rm osmos
docker rmi dockosmos
docker build -t dockosmos .
docker run -d --name osmos dockosmos

docker exec osmos /root/dl.sh dl import select

