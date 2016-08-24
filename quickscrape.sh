#!/bin/bash

# runs quickscrape

# global variables
. $SCRIPTS/GLOBALS.sh

# help
if [ "$2" = '' ]; then
	echo runs quickscrape using a file of URLs 
	echo "
    QUICKSCRAPE
    quickscrape.sh cproject urlsToScrape [scraperdir [frequency]
        proj     (REQD) the project
        urls (REQD) file of urls
        scraperDir   (OPT) scraper directory (defaults to $SCRAPERDIR_GLOBAL)
        freq    (OPT)  (download/min), defaults to 5
	"
	return
fi

echo "SCRIPT..."


FREQ=5

# read the options
TEMP=`getopt --long proj:,urls:,scraperDir::,freq:: -n 'quickscrape.sh' -- "$@"`
eval set -- "$TEMP"

echo "TEMP $TEMP"

# extract options and their arguments into variables.
while true ; do
    case "$1" in
        --freq)
            case "$2" in
                "") FREQ='5' ; shift 2 ;;
                *) FREQ=$2 ; shift 2 ; echo "freq $FREQ" ;;
            esac ;;
        --proj)
            case "$2" in
                "") shift 2 ;;
                *) CPROJ=$2 ; shift 2 ; echo "proj $CPROJ" ;;
            esac ;;
        --scraperDir)
            case "$2" in
                "") shift 2;;
                *) SCRAPERDIR=$2 ; shift 2 ; echo "scraperDir $SCRAPERDIR" ;;
            esac ;;
        --urls)
            case "$2" in
                "") shift 2 ;;
                *) URLFILE=$2 ; shift 2 ; echo "urls $URLS" ;;
            esac ;;
        --) shift ; break ;;
        *) echo "parsing error in quickscrape.sh" ; exit 1 ;;
    esac
done
	
echo "args proj: $CPROJ ; freq $FREQ ; scraperDir $SCRAPERDIR ; urls $URLFILE";


# args

# defaults
if [ "$URLFILE" = '' ]; then
	URLFILE="$PWD/$PROJ/urls.txt"
else 
	URLFILE="$PWD/$URLFILE"
fi
echo "Using urls from $URLFILE"

echo "freq... $FREQ"
 
if [ "$FREQ" = '' ]; then
	FREQ=10
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

QSCMD=" -o $PROJ -r $URLFILE -d $SCRAPERDIR -i $FREQ -c "
echo qscommand $QSCMD
$QUICKSCRAPE $QSCMD

