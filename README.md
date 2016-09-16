# scripts

Scripts (initially BASH but could be others) to run commandline applications.
To instasll quickscrape:
```
npm install --global git+http://github.com/tarrow/getpapers#improveCrossRefSingleFilter
```

## GLOBALS.sh

sets up global variables for later applications. Will need editing for local addresses

## OPENPUBLISHERS.sh

list of open publishers (by Crossref membership)

## OPENLICENSES.sh		

list of open licenses 

## getpaperscrossref.sh

runs getpapers on crossref, optionally using licenses or publishers

## mergeprojects.sh

merge 2 cprojects (e.g. results of crossref on licenses and publishers)

## quickscrape.sh

run quickscrape

## restart.sh

restart a quickscrape (not yet finialised)

## extractshuffle.sh

extract shuffled URLs from CProject

## mergelicpub.sh

merge results of crossref on licenses and publishers

## openarticles.sh

extract data from crossref on open publications

## rename.sh

rename files in ctrees.

## notes

the latest dev release of quickscrape is installed with:
```
npm install -g git+https://github.com/tarrow/quickscrape#enableCMLayout
```

## bugs

### quickscrape/tiny-jsonrpc 

The details will differ according to where `node` is installed. Here's PMR's:
```
Error: Cannot find module '/usr/local/n/versions/node/6.2.1/lib/node_modules/quickscrape/node_modules/spooky/lib/../node_modules/tiny-jsonrpc/lib/tiny-jsonrpc' so moving on to next url in list
Unsafe JavaScript attempt to access frame with URL about:blank from frame with URL file:///usr/local/n/versions/node/6.2.1/lib/node_modules/quickscrape/node_modules/casperjs/bin/bootstrap.js. Domains, protocols and ports must match.
/usr/local/n/versions/node/6.2.1/lib/node_modules/quickscrape/node_modules/eventemitter2/lib/eventemitter2.js:290
          throw arguments[1]; // Unhandled 'error' event
          ^

Error: Child terminated with non-zero exit code 1
    at Spooky.<anonymous> (/usr/local/n/versions/node/6.2.1/lib/node_modules/quickscrape/node_modules/spooky/lib/spooky.js:210:17)
    at emitTwo (events.js:106:13)
    at ChildProcess.emit (events.js:191:7)
    at Process.ChildProcess._handle.onexit (internal/child_process.js:204:12)
```
find where your quickscrape is:
```
which quickscrape
gives:
/usr/local/n/versions/node/6.2.1/bin/quickscrape
create the top level dir 
/usr/local/n/versions/node/6.2.1/
other might have 
/home/$USER/.nvm/versions/node/v6.3.1

```
then copy files from the `lib` directory (after adjusting)
```
cd /usr/local/n/versions/node/6.2.1/lib/node_modules/quickscrape/
cp -r node_modules/tiny-jsonrpc node_modules/spooky/node_modules
```

