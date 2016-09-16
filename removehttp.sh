#!/bin/bash

# removes http_dx_doi_org from ctree names
# normally only used by the system

# global variables
. $SCRIPTS/GLOBALS.sh

# help
if [ $1 = '']; then
    echo "
    REMOVE http
    removehttp.sh cproject file
        cproject     (REQD) the project
    "
    return
fi

# args    
PROJ=$1

# run
CMD=" --project $PROJ --renameFile $OLDFILE $NEWFILE"
#echo qscommand $CMD
$AMIBIN/cproject $CMD
