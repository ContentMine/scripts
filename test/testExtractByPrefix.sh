#!/bin/bash

$SCRIPTS/GLOBALS.sh
PROG=extractByPrefix.sh

CMDEV=${HOME}/workspace/cmdev/
DOWNLOAD=${CMDEV}/cmine-dev/src/test/resources/org/xmlcml/download

PREFIXOUT=${CMDEV}/cmine-dev/target/prefix0
PREFIX=10.1001
CPROJDIR=${DOWNLOAD}/rename

echo "cproj $CPROJDIR"

ARGS=" $CPROJDIR $PREFIXOUT $PREFIX "
echo "$PROG ... $ARGS"

. $SCRIPTS/$PROG $ARGS

if [ ! -e $PREFIXOUT ]; then
	echo "error expected $PREFIXOUT"
else
	echo "file $PREFIXOUT written" 
fi