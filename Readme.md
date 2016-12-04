
Dockerfile for creating postgresql database and import europe
==================

Download and Import OpenStreetMap file into PostgresQL which is then available for query
Can be customized after cloning
See ./_test.sh to build and run the resulting image

Special task involved
------------------

* When in need of disk space, the simplest thing to do is destroy and create a new docker machine
docker-machine create --driver virtualbox --virtualbox-memory "8192" --virtualbox-cpu-count "4" --virtualbox-disk-size "400000" new

Ressources required to import europe
==================

Time required to import europe:
------------------
real    4190m13.084s
user    1m11.864s
sys     1m19.673s


Space used during import europe:
------------------
Filesystem                Size      Used Available Use% Mounted on
/dev/sda1               377.3G    310.7G     47.1G  87% /mnt/sda1/var/lib/docker/aufs

Space used after import:
------------------
Filesystem                Size      Used Available Use% Mounted on
/dev/sda1               377.3G    134.2G    223.7G  37% /mnt/sda1/var/lib/docker/aufs

