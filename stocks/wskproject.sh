#!/bin/bash

# Uncomment for debugging script
#set -x

# Color vars to be used in shell script output
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# capture current state of wsk
CURRENT_NAMESPACE=`wsk property get --namespace | awk '{printf $3}'`
echo "Current namespace is ${CURRENT_NAMESPACE}."

CURRENT_APIHOST=`wsk property get --apihost | awk '{printf $4}'`
echo "Current apihost is ${CURRENT_APIHOST}."

CURRENT_AUTH=`wsk property get --auth | awk '{printf $3}'`
#echo "Current auth is ${CURRENT_AUTH}."

CURRENT_AUTH_HEADER="Authorization: Basic $(echo -n ${CURRENT_AUTH} | base64)"
#echo "Current auth header is ${CURRENT_AUTH_HEADER}"

WSK_CONTENT_HEADER='Content-Type: application/json'

function usage() {
  echo -e "${YELLOW}Usage: $0 [--install, --test, --update, --reinstall, --uninstall]${NC}"
}

function install() {
  echo -e "${YELLOW}Installing OpenWhisk project"

  echo "Creating triggers"
  wsk trigger create stockTrigger

  echo "Creating actions"
  wsk action create processStocks processStocks.js

  echo "Creating rules"
  wsk rule create --enable rule_stock_process stockTrigger processStocks

  echo -e "${GREEN}Install Complete${NC}"
  #wsk list
}

function uninstall() {
  echo -e "${RED}Uninstalling OpenWhisk project"
  
  echo "Removing rules..."
  wsk rule disable rule_stock_process
  wsk rule delete rule_stock_process

  echo "Removing actions..."
  wsk action delete processStocks

  echo "Removing triggers"
  wsk trigger delete stockTrigger

  echo -e "${GREEN}Uninstall Complete${NC}"
  #wsk list
}

function update() {
  echo -e "${YELLOW}Updating OpenWhisk project"
  
  echo "Update actios rules..."
  wsk action update processStocks processStocks.js

  echo -e "${GREEN}Update Complete${NC}"
  #wsk list
}

function test() {
  echo -e "${YELLOW}Testing OpenWhisk project"

  echo "Invoke Action directly via wsk cli"
  wsk action invoke processStocks -b -r -p IBM 200
  


  echo "Invoke Action via curl using HTTP POST"
  WSK_ACTION="processStocks"
  WSK_PARAMS='{ "IBM": "200" }'
  WSK_OPTS='?blocking=true&result=true'
  WSK_PATH="https://${CURRENT_APIHOST}/api/v1/namespaces/${CURRENT_NAMESPACE}/actions/${WSK_ACTION}${WSK_OPTS}"
  curl -d "${WSK_PARAMS}" -XPOST -H "${WSK_CONTENT_HEADER}" -H "${CURRENT_AUTH_HEADER}" "${WSK_PATH}"
  echo ""

  echo "Fire Trigger stockTrigger via wsk cli"
  wsk trigger fire stockTrigger '{"IBM":200}'

  echo "Fire Trigger via curl using HTTP POST"
  WSK_TRIGGER="stockTrigger"
  WSK_PARAMS='{ "IBM": "200" }'
  WSK_PATH="https://${CURRENT_APIHOST}/api/v1/namespaces/${CURRENT_NAMESPACE}/triggers/${WSK_TRIGGER}"
  
  CURL_RESULT=`curl -d "${WSK_PARAMS}" -XPOST -H "${WSK_CONTENT_HEADER}" -H "${CURRENT_AUTH_HEADER}" "${WSK_PATH}"`
  echo ${CURL_RESULT}
  WSK_TRIGGER_ACTIVATION=`echo ${CURL_RESULT} | grep activationId | awk '{printf $3}' | tr -d '"'`
  echo "Trigger activation id is ${WSK_TRIGGER_ACTIVATION}"
  echo ""
  
  echo "Fetch the results from the activation via wsk cli"
  wsk activation get "${WSK_TRIGGER_ACTIVATION}"
  

  echo "Fetch the results from the activation via HTTP GET"
  WSK_PATH="https://${CURRENT_APIHOST}/api/v1/namespaces/_/activations/${WSK_TRIGGER_ACTIVATION}"
  curl -XGET -H "${WSK_CONTENT_HEADER}" -H "${CURRENT_AUTH_HEADER}" "${WSK_PATH}"
  echo ""

  echo -e "${GREEN}Test Complete${NC}"
}


case "$1" in
"--install" )
install
;;
"--uninstall" )
uninstall
;;
"--reinstall" )
uninstall
install
;;
"--update" )
update
;;
"--test" )
test
;;
* )
usage
;;
esac