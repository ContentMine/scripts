#!/bin/bash

TO=$1
FROM=$2
DUPL=$3
if [ $DUPL = '' ]; then
	DUPLMSG="no duplicates stored"
	DUPLSTR=''
else
	DUPLMSG="save duplicates in $DUPL"
	DUPLSTR="--duplicates $DUPL"
fi

TOSAVE=$TO"_save"
echo "copy $TO to $TOSAVE, merge $FROM into $TO; $DUPLMSG"
cp -R $TO $TOSAVE

CPROJ=~/workspace/cmdev/ami-dev/target/appassembler/bin/cproject
CMD=" --project $TO --mergeProjects $FROM $DUPLSTR"
echo cmd $CMD
$CPROJ $CMD