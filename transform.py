#!/usr/local/bin/python3

import argparse,subprocess

#  python3 $SCRIPTS/transform.py --project tom2016-03-07 --transform 

import argparse
parser = argparse.ArgumentParser()
parser.add_argument("--project", help="CProject directory")
parser.add_argument("--transform", help="type: PDF2TXT, jsoup/htmlunit/tidy, XML2HTML")
parser.add_argument("--input", help="e.g. fulltext.pdf ")
parser.add_argument("--output", help="e.g. fulltext.pdf.txt")
parser.add_argument("--exception", help="e.g. ERROR, WARN, DEBUG")
parser.add_argument("--stylesheet", help="stylesheet (optional)")
args = parser.parse_args()

print ("args: "+str(args))

    
#EXENAME = "/home/pm286/cminebin/norma-0.1-SNAPSHOT/bin/norma"
#EXENAME = "/home/pm286/cminebin/ami2-0.1-SNAPSHOT/bin/norma"
EXENAME = "/Users/pm286/workspace/cmdev/ami-dev/target/appassembler/bin/norma"
COMMANDS = [EXENAME, "--project", args.project]

INPUT=None
OUTPUT=None

print ("args.transform "+args.transform)
if args.transform == 'PDF2TXT':
    INPUT = "fulltext.pdf"
    OUTPUT = "fulltext.pdf.txt"
    TRANSFORM = ["--transform", args.transform]
elif args.transform == 'XML2HTML':
    INPUT = "fulltext.xml"
    OUTPUT = "fulltext.xhtml"
    TRANSFORM = ["--transform", args.transform]
elif args.transform == 'HTMLUNIT' or args.transform == 'jsoup' or args.transform == 'TIDY':
    INPUT = "fulltext.html"
    OUTPUT = "fulltext.xhtml"
    TRANSFORM = ["--html", args.transform]  
elif args.transform == None:
    print ("Must give transform")
    quit()
else:
    print ("Bad transform: "+args.transform)
    print ("options: PDF2TXT, jsoup/htmlunit/tidy, XML2HTML")
    quit()
    
COMMANDS += TRANSFORM

print ("input: "+INPUT)

if args.input != None:
    COMMANDS += ["--input", args.input]
else:
    COMMANDS += ["--input", INPUT]

if args.output!= None:
    COMMANDS += ["--output", args.output]
else:
    COMMANDS += ["--output", OUTPUT]

if args.exception != None:
    COMMANDS += ["--exception", args.exception]

print ("commands:"+str(COMMANDS))

subprocess.Popen(COMMANDS)

print ("FINISHED transform; subprocess may still be running")
