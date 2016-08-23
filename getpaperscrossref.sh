#!/bin/bash

# runs getpapers on crossref

# global variables
. GLOBALS.sh

# help
if [ "$1" = "" ]; then
	echo runs getpapers on crossref with list of publishers or licences 
	echo "
    GETPAPERS
    getpaperscrossref.sh cproject filter from until
        cproject     (REQD) the project
        filter       (REQD) type of filter (LICENSE | PUBLISHER)
        from         (OPT)  from date (yyyy-mm-dd) (default all)
        until        (OPT)  until date (yyyy-mm-dd) (default today)
        type         (OPT)  crossref type of publication (default journal-article)
	"
	return
fi
	
# args
PROJECT=$1
FILTER=$2
FROM=$3
UNTIL=$4
TYPE=$5

if [ "$GETPAPERSJS" != "" ]; then
    GETPAPERS=$GETPAPERSJS
else
    GETPAPERS=getpapers
fi

if [ "$TYPE" == "" ]; then
	TYPE="journal-article"
fi

# dates
FROMDATE=",from-pub-date:$FROM"
if [ "$FROM" == "" ]; then
	FROMDATE=""
fi
UNTILDATE=",until-pub-date:$UNTIL"
if [ "$UNTIL" == "" ]; then
    UNTILDATE=""
fi

# filters
MEMBERS=""
LICENSES=""
if [ "$FILTER" == "ALL" ]; then
	echo "using ALL licenses"
elif [ "$FILTER" == "LICENSE" ]; then
		echo "using OPENLICENSES.sh"
		. OPENLICENSES.sh
elif [ "$FILTER" == "PUBLISHER" ]; then
	echo "using OPENPUBLISHERS.sh"
	. OPENPUBLISHERS.sh
else
	echo "unknown filter type $FILTER"
	return
fi

API="--api crossref"
CMD="$API -o $PROJECT --filter type:$TYPE$MEMBERS$LICENSES$FROMDATE$UNTILDATE"

echo running $GETPAPERS $CMD 

$GETPAPERS $CMD

echo "finished getpapers"
