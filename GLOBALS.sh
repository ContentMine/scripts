#!/bin/bash


#export SCRIPTS=${HOME}/workspace/cmdev/scripts
export SCRIPTS=${HOME}/scripts

# edit this to point to scripts directory
if [ "$SCRIPTS" == '' ]; then
	echo "Please set SCRIPTS variable"
	export SCRIPTS=${HOME}/workspace/cmdev/scripts # PMR only
	return
fi

# edit this to the bin directory with the AMI executables
export AMIBIN="${HOME}/ami2-0.1-SNAPSHOT/bin"

# uncomment this to the latest get/pull fo quickscrape
# export QUICKSCRAPEJS="${HOME}/workspace/quickscrape/bin/quickscrape.js"

# uncomment this to the latest get/pull fo quickscrape
# export GETPAPERSJS="${HOME}/workspace/getpapers/bin/getpapers.js"

# edit this to point to scraper directory
export SCRAPERDIR_GLOBAL=${HOME}/journal-scrapers/scrapers
