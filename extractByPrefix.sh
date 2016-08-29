#!/bin/bash

# runs cmine
# extracts CTrees by single DOIPrefix

# global variables
. $SCRIPTS/GLOBALS.sh

PROG=extractByPrefix.sh

# help
if [ "$1" = "" ]; then
	echo runs cmine / still under development
	echo "
    EXTRACT CTrees by prefix
    $PROG 
        proj=        (REQD) the project
        outdir=      (REQD) directory to extract to
		prefix=      (REQD) prefix to extract.
 	"
	return
fi
echo "args?$1?$2?$3?$4?"
CPROJ=$1

if [ "$2" == "" ]; then
	echo "OUTDIR required" 
	return;
fi
OUTDIR=$2

ARGS=" --project $CPROJ --output $OUTDIR"

if [ "$3" == "" ]; then
	echo "PREFIX required" 
	return;
fi
PREFIX="$3"

ARGS="$ARGS --extractByPrefix $PREFIX"

echo "cproj $CPROJ"
echo "outdir $OUTDIR"
echo "prefix $PREFIX"
echo "prefixfile $PREFIXFILE"
echo "args $ARGS"

echo running $CPROJECT $ARGS 

$CPROJECT $ARGS 

