#!/bin/sh

set -e

pwd

PBFIMPORT=latest.osm.pbf
while [ $# -gt 0 ] ; do
	case $1 in
	dl)
		PBF=languedoc-roussillon-latest.osm.pbf
		wget http://download.geofabrik.de/europe/france/$PBF
		mv $PBF $PBFIMPORT
		;;
	dl-france)
		PBF=france-latest.osm.pbf
		wget http://download.geofabrik.de/europe/$PBF
		mv $PBF $PBFIMPORT
		;;
	import)
		osm2pgsql --number-processes 3 --cache 6000 -j -G --slim --latlong --drop -H localhost -U osm $PBFIMPORT
		;;
	select)
		psql gis osm -c "select * from planet_osm_point where name='Montpellier' ;"
		;;
	psql)
		psql gis osm
		;;
	*)
		echo "$0 dl|import|select|psql"
		;;
	esac

	shift
done
