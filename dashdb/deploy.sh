#!/bin/bash

AUTH=`wsk property get --auth | awk '{printf $3}'`
echo $AUTH

zip action.zip index.js

ACTION_NAME="dash_db"

ACTION_SOURCE=`cat action.zip -n | base64`

ACTION_DOCKER_IMAGE="csantanapr/action-nodejs-ibm-v6"

#creating action, binary=true using a zip

curl -u $AUTH -d '{"namespace":"_","name":"$ACTION_NAME","exec":{"kind":"blackbox","code":"$ACTION_SOURCE","image":"$ACTION_DOCKER_IMAGE"}}' -X PUT -H "Content-Type: application/json" https://openwhisk.ng.bluemix.net/api/v1/namespaces/_/actions/dash_db2?overwrite=true -v

