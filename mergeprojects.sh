#!/bin/bash

# merge projects

# global variables
. GLOBALS.sh

# help
if [ $2 = '']; then
    echo "
    MERGE PROJECT 
	# merge otherproj into cproject
    mergeprojects.sh cproject otherproject [duplicates] [save]
        cproject     (REQD) the project
        otherproj    (REQD) project to merge in
        duplicates   (OPT)  new project containing duplicates
		save         (OPT)  if non-empty copy cproject to $cproject_save for safety
    "
    return
fi

# args    
TO=$1
FROM=$2
DUPL=$3
SAVE=$4

DUPLSTR=""
if [ $DUPL != '' ]; then
	echo save duplicates in $DUPL"
	DUPLSTR="--duplicates $DUPL"
fi

if [ $SAVE != '']; then
	TOSAVE=$TO_save
	echo "save $TO to $TOSAVE"
	cp -R $TO $TOSAVE
fi

CMD=" --project $TO --mergeProjects $FROM $DUPLSTR"
#echo cmd $CMD
$AMIBIN/cproject $CMD

