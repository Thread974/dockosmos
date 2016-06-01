FROM openfirmware/postgres-osm:latest

# Implicit from postgres
# EXPOSE 5432

RUN apt-get update
RUN apt-get -y install osm2pgsql
RUN apt-get -y install wget

ADD ./dockosm.sh /docker-entrypoint-initdb.d/dockosm.sh
RUN chmod +x     /docker-entrypoint-initdb.d/dockosm.sh

ADD ./dl.sh       /root/dl.sh
RUN chmod +x      /root/dl.sh

# eof
