#!/bin/bash

# runs cmine
# extracts CTrees by DOIPrefixes in a file

# global variables
. $SCRIPTS/GLOBALS.sh

PROG=extractByPrefixFile.sh

# help
if [ "$1" = "" ]; then
	echo runs cmine / still under development
	echo "
    EXTRACT CTrees by prefix
    $PROG 
        proj=        (REQD) the project
        outdir=      (REQD) directory to extract to
		prefixFile=  (REQD) file with prefixes to extract 
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
	echo "PREFIXFILE required" 
	return;
fi
PREFIXFILE="$3"

ARGS="$ARGS --input $PREFIXFILE --extractByPrefix "

echo "cproj $CPROJ"
echo "outdir $OUTDIR"
echo "prefixfile $PREFIXFILE"
echo "args... $ARGS"
		
echo running $CPROJECT $ARGS 

$CPROJECT $ARGS 

echo "============="
echo "wrote $OUTDIR"
echo "============="

