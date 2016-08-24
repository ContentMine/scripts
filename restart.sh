#!/bin/bash

# global variables
. $SCRIPTS/GLOBALS.sh

# help
if [ "$1" == '' ]; then
    echo "
    CREATE RESTART LIST OF URLS
    takes list of URLS (INURLS) and finds those that have not been downloaded
    restart.sh cproject inUrls outUrls
        cproject     (REQD) the project
        inUrls       (OPT)  old name within ctree (default: urls.txt) (generally stays constant)
        newfile      (OPT)  new name within ctree (default: outUrls.txt)
        markEmpty    (OPT)  adds empty Quickscrape metadata in cTree
    "
    return
fi


# args    
PROJ=$1
INURLS=$PROJ/urls.txt
OUTURLS=outUrls.txt
if [ "$FREQ" == '' ]; then
    FREQ=$FREQ_GLOBAL
fi
echo "FREQ $FREQ"

$SCRIPTS/rename.sh $PROJ quickscrape_results.json quickscrape_result.json

cp $INURLS $PROJ/urls.txt-save
ls -lt $PROJ/urls.txt-save

CMD=" --project $PROJ --inUrls $INURLS markEmpty --outUrls $OUTURLS"
echo command $CMD
$AMIBIN/cproject $CMD
cp $PROJ/outUrls.txt $INURLS
echo "IN again $INURLS"
. $SCRIPTS/quickscrape.sh $PROJ $INURLS $FREQ $SCRAPERDIR_GLOBAL 
echo "finished"