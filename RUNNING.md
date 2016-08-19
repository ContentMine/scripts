# Extracting Open papers

## run getpapers

commands are assembled in two files:
### openpublishers.sh

 uses a list of the most prolific fully-open publishers (by Crossref member id):
```` 
 #!/bin/bash

 OUTPUT=$1
 FROM=$2
 TO=$3
 echo open papers from $FROM to $TO in directory $OUTPUT
 GETPAPERS=/users/pm286/workspace/getpapers/
 $GETPAPERS/bin/getpapers.js \
 --api crossref \
 -o $OUTPUT \
 --filter \
 member:340\
 ,member:98\
 ,member:2581\
 ,member:1968\
 ,member:3145\
 ,member:1965\
 ,member:895\
 ,member:2549\
 ,member:2620\
 ,member:2258\
 ,member:3285\
 ,type:journal-article\
 ,from-pub-date:$FROM\
 ,until-pub-date:$TO
 ````
 called by (example is a single days worth)
 ````
 ./openpublishers.sh pub20160201 2016-02-01 2016-02-01
 ```
 `
### openlicenses.sh
 
uses a list of the commonest OA/CC licenses 
 ```
 #!/bin/bash

OUTPUT=$1
FROM=$2
TO=$3
echo open papers from $FROM to $TO in directory $OUTPUT
GETPAPERS=/users/pm286/workspace/getpapers/
$GETPAPERS/bin/getpapers.js \
--api crossref \
-o $OUTPUT \
--filter \
license.url:http%3A%2F%2Fcreativecommons.org%2Flicenses%2Fby\
,license.url:http%3A%2F%2Fcreativecommons.org%2Flicenses%2Fby%2F4.0\
,license.url:http%3A%2F%2Fcreativecommons.org%2Flicenses%2Fby%2F4.0%2F\
,license.url:http%3A%2F%2Fcreativecommons.org%2Flicenses%2Fby%2F3.0\
,license.url:http%3A%2F%2Fcreativecommons.org%2Flicenses%2Fby%2F3.0%2F\
,licence.url:http%3A%2F%2Fcreativecommons.org%2Flicenses/by-nc-nd%2F3.0\
,licence.url:http%3A%2F%2Fcreativecommons.org%2Flicenses/by-nc-nd%2F3.0%2F\
,licence.url:http%3A%2F%2Fcreativecommons.org%2Flicenses/by-nc-nd%2F4.0\
,licence.url:http%3A%2F%2Fcreativecommons.org%2Flicenses/by-nc-nd%2F4.0%2F\
,from-pub-date:$FROM\
,until-pub-date:$TO\

 ```
 called by (example is a single days worth)
 ```
 ./openlicenses.sh lic20160201 2016-02-01 2016-02-01
 ```

## create AMI executables

Commandline code is in `cmine`, but run through `ami` .
```
cd <ami> directory
```
copy/unzip `target/ami2-0.1-SNAPSHOT-bin.zip` to your own directory (or run `target/appassembler/bin` scripts)

then 
run `pman` in `bin` (denoted by $PMAN)

## merge open
the project directory will be edited, so it may be valuable to copy.

```
cp -R  pub20160201 pub20160201-save // for safety
$PMAN --project pub20160201 --mergeProject lic20160201 --duplicates licpub20160201
```

### mergelicpub.sh

bash script for this, 
```
mergelicpub.sh [pub] [lic] [dupl]

where `pub` is the crossref publisher derived papers
where `lic` is the crossref license derived papers
where `dupl` is the optional output directory for metadata in both
```

```
!/bin/bash

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
```
 

## extract URLs for quickscrape


### cmine extract publisher URLS and shuffle

Extract URLs from result of `getpapers` on publishers and shuffle them .
```
$PMAN --project pub20160201 --extractUrls urls.txt shuffle
```

This will create a file `pub20160201/urls.txt` with all the URLs from the `crossref_result.json` files.
  
### cmine extract license URLS and shuffle

Extract URLs from result of `getpapers` on licenses and shuffle them .
```
$PMAN --project lic20160201 --extractUrls urls.txt shuffle
```

This will create a file `lic20160201/urls.txt` with all the URLs from the `crossref_result.json` files.
  
## scrape the URLs

Use quickscrape with the list of shuffled URLs and use a high frequency. Put outputs in a separate directory and merge later. The path to the scraper directory will need changing. The `cTree` names may need normalizing so they can be merged.

### quickscrape publishers

```
quickscrape -o pub20160201q -r pub20160201/urls.txt -d ../../journal-scrapers/scrapers/ -i 20
```

If `cTree`s start with `http` use the following:

To normalize the `cTree` names:
```
$PMAN --project pub20160201 --
```


### quickscrape licenses

```
quickscrape -o lic20160201q -r lic20160201/urls.txt -d ../../journal-scrapers/scrapers/ -i 20
```


../bin/ami2-0.1-SNAPSHOT/bin/pman --project stratman --inUrls urls.txt markEmpty --outUrls outUrls.txt
quickscrape -o stratman -r stratman/outUrls.txt -d ../../chjh3/journal-scrapers/scrapers -i 10  cmd

## normalize 