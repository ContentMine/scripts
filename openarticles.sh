#!/bin/bash

# create open date-limited download

# global variables
. $SCRIPTS/GLOBALS.sh

# help
if [ "$3" == '' ]; then
    echo "
    DOWNLOAD OPEN ARTICLES
    uses default publishers and licenses
    requires a projectroot forming the base name of subprojects, e.g.
	  test generates test2016-07_pub, etc.
	runs getpapers for llicenses and publishers
	merges and extracts URLs
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

# get open articles by license
. $SCRIPTS/getpaperscrossref.sh ${PROJECTROOT}${FROM}_lic LICENSE $FROM $UNTIL

# get open articles by publisher
. $SCRIPTS/getpaperscrossref.sh ${PROJECTROOT}${FROM}_pub PUBLISHER $FROM $UNTIL

# merge them
$AMIBIN/cproject --project "$PROJECTROOT$FROM"_pub  --mergeProjects "$PROJECTROOT$FROM"_lic 

# extract and shuffle URLs
. $SCRIPTS/extractshuffle.sh "$PROJECTROOT$FROM"_pub urls.txt shuffle

# quickscrape the URLS, use $SCRAPERDIR_GLOBAL by default
PROJ="$PROJECTROOT$FROM"_pub
echo "PROJ $PROJ"
. $SCRIPTS/quickscrape.sh $PROJ "$PROJ"/urls.txt 20
#. quickscrape.sh 