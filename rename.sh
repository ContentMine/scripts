#!/bin/bash

# renames files in CTree
# normally only used by the system

# global variables
. GLOBALS.sh

# help
if [ $3 = '']; then
    echo "
    RENAME FILES
    rename.sh cproject file
        cproject     (REQD) the project
        oldfile      (OPT)  old name within ctree (default: results.json)
        newfile      (OPT)  new name within ctree (default: quickscrape_result.json)
    "
    return
fi

# args    
PROJ=$1
OLDFILE=$2
NEWFILE=$3

# run
CMD=" --project $PROJ --renameFile $OLDFILE $NEWFILE"
#echo qscommand $CMD
$AMIBIN/cproject $CMD
