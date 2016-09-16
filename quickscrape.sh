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
        urls     (REQD) file of urls
        scraperDir   (OPT) scraper directory (defaults to $SCRAPERDIR_GLOBAL)
        freq    (OPT)  (download/min), defaults to 5
        level   (OPT)  debug level (defaults to debug)
	"
	return
fi

FREQ=17
CPROJ=""
SCRAPERDIR=""
URLFILE=""

# read the options
TEMP=`getopt --long freq:,proj:,scraperDir:,urls: -n 'quickscrape.sh' -- "$@"`
echo "SCRIPT..."


FREQ=30
LEVEL='info'
URLFILE="$PROJ/urls.txt"
SCRAPERDIR=$SCRAPERDIR_GLOBAL

# read the options
TEMP=`getopt --long proj:,urls:,scraperDir:,freq:,level: -n 'quickscrape.sh' -- "$@"`
eval set -- "$TEMP"
getopt

# extract options and their arguments into variables.
while true ; do
    case "$1" in
        --freq)
            case "$2" in
                "") shift 2 ;;
                *) FREQ=$2 ; shift 2 ;;
            esac ;;
        --level)
            case "$2" in
                "") LEVEL='debug' ; shift 2 ;;
                *) LEVEL=$2 ; shift 2 ;;
            esac ;;
        --proj)
            case "$2" in
                "") shift 2 ;;
                *) CPROJ=$2 ; shift 2 ;;
            esac ;;
        --scraperDir)
            case "$2" in
                "") shift 2;;
                *) SCRAPERDIR=$2 ; shift 2 ;;
            esac ;;
        --urls)
            case "$2" in
                "") shift 2 ;;
                *) URLFILE=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "parsing error in quickscrape.sh" ; exit 1 ;;
    esac
done
	
echo "QUICKSCRAPE: proj: $CPROJ ; freq $FREQ ; scraperDir $SCRAPERDIR ; urls $URLFILE";

# args

echo "Using urls from $URLFILE"

echo "freq... $FREQ"
 
if [ "$FREQ" = '' ]; then
	FREQ=10
fi
echo "SCRAPER_DIR>> $SCRAPERDIR"
if [ "$SCRAPERDIR" = '' ]; then
	SCRAPERDIR=$SCRAPERDIR_GLOBAL
fi
if [ "$SCRAPERDIR" = '' ]; then
    echo "must give SCRAPERDIR"
	return
fi
echo "SCRAPER_DIR>>> $SCRAPERDIR"

if [ "$QUICKSCRAPEJS" != '' ]; then
    QUICKSCRAPE=$QUICKSCRAPEJS
else
    QUICKSCRAPE=quickscrape
fi
echo $QUICKSCRAPE on $URLFILE into $PROJ rate $FREQ

# to install quickscrape 
# npm install -g git+https://github.com/tarrow/quickscrape#enableCMLayout

#defaults

echo "run quickscrape on $PROJ; urls=$URLFILE; scrapers=$SCRAPERDIR; freq=$FREQ"

DATE=`date +%Y-%m-%d-%H-%M`
LOGFILE="$PROJ/quickscrape.$DATE.log"

QSCMD=" -o $PROJ -r $URLFILE -d $SCRAPERDIR -i $FREQ -c -l $LEVEL --logfile $PROJ/test1.log"
echo qscommand $QSCMD
$QUICKSCRAPE $QSCMD  2>&1 | tee $LOGFILE

