#!/bin/sh
set -e

[ -z "$OSM_ROOT_DIR" ] && OSM_ROOT_DIR=.

# File that will be imported
PBFIMPORT=$OSM_ROOT_DIR/latest.osm.pbf

cd $OSM_ROOT_DIR
pwd

while [ $# -gt 0 ] ; do
	case $1 in
	dl)
		PBF=languedoc-roussillon-latest.osm.pbf
		[ -r $PBF ] || wget http://download.geofabrik.de/europe/france/$PBF
		rm -f $PBFIMPORT
		ln $PBF $PBFIMPORT
		;;
	dl-france)
		PBF=france-latest.osm.pbf
		[ -r $PBF ] || wget http://download.geofabrik.de/europe/$PBF
		rm -f $PBFIMPORT
		ln $PBF $PBFIMPORT
		;;
	dl-europe)
		PBF=europe-latest.osm.pbf
		[ -r $PBF ] || wget http://download.geofabrik.de/$PBF
		rm -f $PBFIMPORT
		ln $PBF $PBFIMPORT
		;;
	dl-planet)
		PBF=planet-latest.osm.pbf
		[ -r $PBF ] || wget http://mirror2.shellbot.com/osm/$PBF
		rm -f $PBFIMPORT
		ln $PBF $PBFIMPORT
		;;
	import)
		osm2pgsql --number-processes 3 --cache 2000 -j -G --slim --latlong --drop -H localhost -U osm $PBFIMPORT
		;;
	select)
		psql gis osm -c "select * from planet_osm_point where name='Montpellier' ;"
		;;
	psql)
		psql gis osm
		;;
	*)
		echo "$0 dl|dl-france|dl-europe|dl-planet|import|select|psql"
		;;
	esac

	shift
done

