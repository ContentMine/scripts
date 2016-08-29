#!/bin/bash

# runs getpapers on crossref

# global variables
. $SCRIPTS/GLOBALS.sh

# help
if [ "$1" = "" ]; then
	echo runs getpapers on crossref with list of publishers or licences 
	echo "
    GETPAPERS
    getpaperscrossref.sh cproject filter from until
        proj=        (REQD) the project
        filter=      (REQD) type of filter (LICENSE | PUBLISHER)
        from=        (OPT)  from date (yyyy-mm-dd) (default all)
        until=       (OPT)  until date (yyyy-mm-dd) (default today)
        type=        (OPT)  crossref type of publication (default journal-article)
	"
	return
fi

	
if [ "$1" == '' ]; then
	echo "NO Project given";
	return;
fi
CPROJ=$1

if [ "$2" == '' ]; then
	echo "NO Filter given";
	return;
fi

# filters
MEMBERS=""
LICENSES=""
FILTER=$2
if [ "$FILTER" == "ALL" ]; then
	echo "using ALL licenses"
elif [ "$FILTER" == "LICENSE" ]; then
		echo "using OPENLICENSES.sh"
		. $SCRIPTS/OPENLICENSES.sh
elif [ "$FILTER" == "PUBLISHER" ]; then
	echo "using OPENPUBLISHERS.sh"
	. $SCRIPTS/OPENPUBLISHERS.sh
else
	echo "unknown filter type $FILTER"
	return
fi

if [ "$3" == '' ]; then
	echo "NO Fromdate given";
	return;
fi
FROMDATE=",from-pub-date:$FROM"
FROM=$3

if [ "$4" == '' ]; then
	echo "NO Untildate given";
	return;
fi
UNTIL=$4
UNTILDATE=",until-pub-date:$UNTIL"


API="--api crossref"
CMD="$API -o $PROJECT --filter type:$TYPE$MEMBERS$LICENSES$FROMDATE$UNTILDATE"

echo running $GETPAPERS $CMD 

$GETPAPERS $CMD

