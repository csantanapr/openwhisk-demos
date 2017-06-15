#!/bin/bash
set -e

# Setup environment
OPENWHISK_ACTION_DOCKER_IMAGE=${OPENWHISK_ACTION_DOCKER_IMAGE:="csantanapr/action-nodejs-ibm-v6"}
OPENWHISK_ACTION_NAME=${OPENWHISK_ACTION_NAME:="dash_db"}
OPENWHISK_HOST=${OPENWHISK_HOST:=`wsk property get --apihost | awk '{printf $4}'`}
OPENWHISK_AUTH=${OPENWHISK_AUTH:=`wsk property get --auth | awk '{printf $3}'`}

# Create action zip with source code
echo Creating action.zip using src/*
pushd src > /dev/null
zip -r ../action.zip *
popd > /dev/null
OPENWHISK_ACTION_SOURCE=`cat action.zip | base64`


# Create action, binary=true using a zip
echo Deploying OpenWhisk action $OPENWHISK_ACTION_NAME using image $OPENWHISK_ACTION_DOCKER_IMAGE to host $OPENWHISK_HOST
curl -u $OPENWHISK_AUTH -d '{"namespace":"_","name":"'"$OPENWHISK_ACTION_NAME"'","exec":{"kind":"blackbox","code":"'"$OPENWHISK_ACTION_SOURCE"'","image":"'"$OPENWHISK_ACTION_DOCKER_IMAGE"'"}}' -X PUT -H "Content-Type: application/json" https://$OPENWHISK_HOST/api/v1/namespaces/_/actions/$OPENWHISK_ACTION_NAME?overwrite=true -v


