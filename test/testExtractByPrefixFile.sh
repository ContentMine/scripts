#!/bin/bash

$SCRIPTS/GLOBALS.sh
PROG=extractByPrefixFile.sh

CMDEV=${HOME}/workspace/cmdev/
DOWNLOAD=${CMDEV}/cmine-dev/src/test/resources/org/xmlcml/download

PREFIXIN=${DOWNLOAD}/prefixes1.txt
PREFIXOUT=${CMDEV}/cmine-dev/target/prefixList
CPROJDIR=${DOWNLOAD}/rename

echo "cproj $CPROJDIR"

ARGS=" $CPROJDIR $PREFIXOUT $PREFIXIN "
echo "$PROG ... $ARGS"

. $SCRIPTS/$PROG $ARGS

if [ ! -e $PREFIXOUT ]; then
	echo "error expected $PREFIXOUT"
else
	echo "file $PREFIXOUT written" 
fi