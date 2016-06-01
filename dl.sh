#!/bin/sh

pwd

while [ $# -gt 0 ] ; do
	case $1 in
	dl)
		wget http://download.geofabrik.de/europe/france/languedoc-roussillon-latest.osm.pbf
		;;
	import)
		osm2pgsql --number-processes 3 --cache 2000 --slim --latlong  -H localhost -U osm languedoc-roussillon-latest.osm.pbf
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
