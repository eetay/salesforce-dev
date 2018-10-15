#!/bin/bash

if [ -z "$1" ]
then
    SF_ENV="development"
else
    SF_ENV=$1
fi

SF_PACKAGE=`pwd -P`/src
MYPATH=`(readlink $0 || echo $0)`
pushd `dirname $MYPATH`
MYDIR=`pwd -P`
echo "XXX $MYDIR"
JSFORCE_DEPLOY=`which jsforce-deploy`
if [ ! -f "$JSFORCE_DEPLOY" ]; then
  JSFORCE_DEPLOY=$MYDIR/node_modules/jsforce-metadata-tools/bin/jsforce-deploy
  if [ ! -f "$JSFORCE_DEPLOY" ]; then
    echo "> FAILED TO DETECT jsforce-deploy LOCATION, INSTALLING"
    yarn
  fi
fi
popd
echo "jsforce-deploy in $JSFORCE_DEPLOY"

CREDS_FILE=$MYDIR/credentials
EXTRAPARAMS=" --verbose --rollbackOnError"

source $CREDS_FILE
if [ -z "$SF_USER" ]
then
  echo "SF_ENV not set, use: [development|team|review]"
  exit 1
fi


echo "Deploying package to server (env: $SF_ENV, user: $SF_USER)"
echo "EXTRAPARAMS=$EXTRAPARAMS"
echo "using jsforce-deploy from: $JSFORCE_DEPLOY"

"$JSFORCE_DEPLOY" $EXTRAPARAMS --pollInterval 15000 --pollTimeout 1840000 -u $SF_USER -p "$SF_PASS$SF_TOKEN" -D $SF_PACKAGE/ | tee deploy.log
