#!/bin/bash

# runs quickscrape

# global variables
. GLOBALS.sh

# help
if [ "$2" = '' ]; then
	echo runs quickscrape using a file of URLs 
	echo "
    QUICKSCRAPE
    quickscrape.sh cproject urlsToScrape [scraperdir [frequency]
        cproject     (REQD) the project
        urlsToScrape (REQD) file of urls
        scraperDir   (OPT) scraper directory (defaults to $SCRAPERDIR_GLOBAL)
        frequency    (OPT)  (download/min), defaults to 5
	"
	return
fi
	
echo "args $1; $2; $3; $4"
# args
PROJ=$1
URLFILE=$2
FREQ=$3
SCRAPERDIR=$4

# defaults
if [ "$URLFILE" = '' ]; then
	URLFILE="$PWD/$PROJ/urls.txt"
else 
	URLFILE="$PWD/$URLFILE"
fi
echo "Using urls from $URLFILE"

if [ "$FREQ" = '' ]; then
	FREQ=5
fi

if [ "$SCRAPERDIR" = '' ]; then
	SCRAPERDIR=$SCRAPERDIR_GLOBAL
fi
if [ "$SCRAPERDIR" = '' ]; then
    echo "must give SCRAPERDIR"
	return
fi

if [ "$QUICKSCRAPEJS" != '' ]; then
    QUICKSCRAPE=$QUICKSCRAPEJS
else
    QUICKSCRAPE=quickscrape
fi
echo $QUICKSCRAPE on $URLFILE into $PROJ rate $FREQ

#defaults

echo "run quickscrape on $PROJ; urls=$URLFILE; scrapers=$SCRAPERDIR; freq=$FREQ"

QSCMD=" -o $PROJ -r $URLFILE -d $SCRAPERDIR -i $FREQ "
echo qscommand $QSCMD
$QUICKSCRAPE $QSCMD
