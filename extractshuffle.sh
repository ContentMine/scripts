#!/bin/bash

# extract urls from project

# global variables
. GLOBALS.sh

# help
if [ "$1" = '' ]; then
    echo "
    EXTRACT URLS
    extractshuffle.sh cproject urlfile
        cproject     (REQD) the project
        urlfile      (OPT) filename for output of urls (default: urls.txt)
        shuffle      (OPT) if non-empty shuffles URLs
    "
    return
fi


PROJ=$1
URLS=$2
SHUFFLE=shuffle

# default
if [ "$URLS" = '' ]; then
    URLS=urls.txt
fi
if [ "$3" = '' ]; then
    SHUFFLE=''
fi

echo "extract urls from $PROJ to $URLS, shuffle=$SHUFFLE"
CMD=" --project $PROJ --outUrls $URLS $SHUFFLE"
#echo cmd $CMD
$AMIBIN/cproject $CMD