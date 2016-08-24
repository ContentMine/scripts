#!/bin/bash

# create open date-limited download

# global variables
. $SCRIPTS/GLOBALS.sh

# help
if [ "$3" == '' ]; then
    echo "
    DOWNLOAD ALL ARTICLES
    uses all publishers 
    requires a projectroot forming the base name of subprojects, e.g.
	  test generates test2016-07_pub, etc.
	runs getpapers for crossref
	extracts URLs
	then runs quickscrape
		
    openarticles projectroot fromdate untildate
        projectroot  (REQD) root of subprojects
        fromdate     (REQD) start date inclusive
        untildate    (REQD) finish date inclusive
    "
    return
fi

# args    
PROJECTROOT=$1
FROM=$2
UNTIL=$3

# get all articles
. $SCRIPTS/getpaperscrossref.sh ${PROJECTROOT}${FROM} ALL $FROM $UNTIL

# extract and shuffle URLs
. $SCRIPTS/extractshuffle.sh "$PROJECTROOT$FROM" urls.txt shuffle
echo "extracted to $PROJECTROOT$FROM urls.txt"

# quickscrape the URLS, use $SCRAPERDIR_GLOBAL by default
PROJ="$PROJECTROOT$FROM"
echo "PROJ $PROJ"
. $SCRIPTS/quickscrape.sh $PROJ "$PROJ"/urls.txt 20
#. quickscrape.sh 
