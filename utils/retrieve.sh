#!/bin/bash
if [ -z "$1" ]
then
    SF_ENV="development"
else
    SF_ENV=$1
fi

SF_PACKAGE=`pwd -P`/src
pushd `dirname $0`
MYDIR=`pwd -P`
JSFORCE_RETRIEVE=`which jsforce-retrieve`
if [ ! -f "$JSFORCE_RETRIEVE" ]; then
  JSFORCE_DEPLOY=$MYDIR/node_modules/jsforce-metadata-tools/bin/jsforce-retrieve
  if [ ! -f "$JSFORCE_RETRIEVE" ]; then
    echo "> FAILED TO DETECT jsforce-retrieve LOCATION, INSTALLING"
    yarn
  fi
fi
popd
echo "jsforce-retrieve in $JSFORCE_DEPLOY"

CREDS_FILE=$MYDIR/credentials
SF_PACKAGE=./src
TMP=./retrievedPackage

if [ -z "$DIFF" ]; then
  DIFFMERGE=`which diffmerge`
  OPENDIFF=`which opendiff`
  if [ -n "$DIFFMERGE" ]; then
    DIFF="$DIFFMERGE -t1=Current -t2=Retrieved "
  elif [ -n "$OPENDIFF" ]; then
    DIFF="$OPENDIFF "
  else
    DIFF="cp -rf "
  fi
fi

if [ "$SF_USER" == "" ] ; then
  source $CREDS_FILE
fi

echo "Retrieving '$SF_ENV' into $TMP"
rm -rf $TMP
jsforce-retrieve  --pollInterval 5000 --pollTimeout 1840000 -u "$SF_USER" -p "$SF_PASS$SF_TOKEN" -P $SF_PACKAGE/package.xml -D $TMP && echo $DIFF $TMP $SF_PACKAGE && $DIFF $TMP $SF_PACKAGE
echo "Done"
