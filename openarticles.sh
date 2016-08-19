#!/bin/bash

# create open date-limited download

# global variables
. GLOBALS.sh

# help
if [ "$3" == '' ]; then
    echo "
    DOWNLOAD OPEN ARTICLES
    uses default publishers and licenses
    requires a projectroot forming the base name of subprojects
	
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
#. getpaperscrossref.sh ${PROJECTROOT}${FROM}_lic LICENSE $FROM $UNTIL

# get open articles by publisher
#. getpaperscrossref.sh ${PROJECTROOT}${FROM}_pub PUBLISHER $FROM $UNTIL

# merge them
#$AMIBIN/cproject --project "$PROJECTROOT$FROM"_pub  --mergeProjects "$PROJECTROOT$FROM"_lic 

# extract and shuffle URLs
#. extractshuffle.sh "$PROJECTROOT$FROM"_pub urls.txt shuffle

# quickscrape the URLS, use $SCRAPERDIR_GLOBAL by default
PROJ="$PROJECTROOT$FROM"_pub
echo "PROJ $PROJ"
. quickscrape.sh $PROJ "$PROJ"/urls.txt 20
#. quickscrape.sh 