#!/bin/bash

if [ -z "$1" ]
then
    SF_ENV="development"
else
    SF_ENV=$1
fi

pushd `dirname $0`
SF_PACKAGE=`pwd -P`
popd
CREDS_FILE="`find $SF_PACKAGE/../config/credentials $SF_PACKAGE/../../../../config/credentials -print -quit 2> /dev/null`"
EXTRAPARAMS=" --verbose --rollbackOnError"
JSFORCE_DEPLOY=`which jsforce-deploy`

if [ ! -f "$JSFORCE_DEPLOY" ]; then
  echo "-------------- FAILED TO DETECT jsforce-deploy LOCATION, DOING WORKAROUND -----------"
  echo "> SF_ENV= $SF_ENV"
  PREFIX=$HOME
  yarn global add jsforce-metadata-tools --prefix $PREFIX
  echo "> module path: $PREFIX"
  echo "> PATH = $PATH"
  echo "> which jsforce-deploy is: "
  which jsforce-deploy
  echo "> ls folder where jsforce should be:"
  ls -la $PREFIX/bin
  echo "--------------"
  JSFORCE_DEPLOY=$PREFIX/bin/jsforce-deploy
fi

source $CREDS_FILE
if [ -z "$SF_USER" ]
then
  echo "SF_ENV not set, use: [development|team|review]"
  exit 1
fi


echo "Deploying package to server (env: $SF_ENV, user: $SF_USER)"
echo "EXTRAPARAMS=$EXTRAPARAMS"
echo "using jsforce-deploy from: $JSFORCE_DEPLOY"

"$JSFORCE_DEPLOY" $EXTRAPARAMS --pollInterval 15000 --pollTimeout 1840000 -u $SF_USER -p $SF_PASS$SF_TOKEN -D $SF_PACKAGE/ | tee deploy.log
