#!/bin/bash

# not yet developed

PROJ=$1
FREQ=10
QUICKSCRAPE=quickscrape
AMIROOT=~/workspace/cmdev/ami-dev/target
AMIBIN="$AMIROOT/appassembler/bin"
CPROJ="$AMIBIN/cproject"

SCRAPERDIR=~/workspace/journal-scrapers/scrapers
URLS=urls.txt
OUTURLS=outUrls.txt

echo "run quickscrape extract urls from $PROJ to $URLS_TXT, shuffle=$SHUFFLE"

PROJCMD=" --project $PROJ --inUrls $URLS markEmpty --outUrls $OUTURLS"
echo projcommand $PROJCMD
$CPROJ $PROJCMD

QSCMD=" -o $PROJ -r $PROJ/outUrls.txt -d $SCRAPERDIR -i $FREQ"
echo qscommand $QSCMD
$QUICKSCRAPE $QSCMD
