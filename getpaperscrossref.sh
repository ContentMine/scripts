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

# read the options
TEMP=`getopt --long proj:,filter:,from:,until:,type: -n 'getpaperscrossref.sh' -- "$@"`
eval set -- "$TEMP"
getopt

TYPE="journal-article"

# extract options and their arguments into variables.
while true ; do
    case "$1" in
        --proj)
            case "$2" in
                *) CPROJ=$2 ; shift 2 ;;
            esac ;;
        --filter)
            case "$2" in
                *) FILTER=$2 ; shift 2 ;;
            esac ;;
        --from)
            case "$2" in
                "") shift 2;;
                *) FROM=$2 ; shift 2 ;;
            esac ;;
        --until)
            case "$2" in
                "") shift 2 ;;
                *) UNTIL=$2 ; shift 2 ;;
            esac ;;
        --type)
            case "$2" in
                "") shift 2 ;;
                *) TYPE=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "parsing error in getpaperscrossref.sh" ; exit 1 ;;
    esac
done
	
if [ "$CPROJ" == '' ]; then
	echo "NO Project given";
	return;
fi

if [ "$GETPAPERSJS" != "" ]; then
    GETPAPERS=$GETPAPERSJS
else
    GETPAPERS=getpapers
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
		. $SCRIPTS/OPENLICENSES.sh
elif [ "$FILTER" == "PUBLISHER" ]; then
	echo "using OPENPUBLISHERS.sh"
	. $SCRIPTS/OPENPUBLISHERS.sh
else
	echo "unknown filter type $FILTER"
	return
fi

API="--api crossref"
CMD="$API -o $PROJECT --filter type:$TYPE$MEMBERS$LICENSES$FROMDATE$UNTILDATE"

echo running $GETPAPERS $CMD 

$GETPAPERS $CMD

