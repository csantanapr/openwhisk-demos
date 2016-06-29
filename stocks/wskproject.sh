#!/bin/bash

# Uncomment for debugging script
#set -x

# Color vars to be used in shell script output
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# capture the namespace where actions will be created
CURRENT_NAMESPACE=`wsk property get --namespace | awk '{print $3}'`
echo "Current namespace is $CURRENT_NAMESPACE."

function usage() {
  echo -e "${YELLOW}Usage: $0 [--install,--test,--update,--reinstall]${NC}"
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
  curl -d '{ "IBM": "200" }' "https://openwhisk.ng.bluemix.net/api/v1/namespaces/$CURRENT_NAMESPACE/actions/processStocks?blocking=true&result=true" -XPOST -H 'Content-Type: application/json' -H "Authorization: Basic $(wsk property get --auth | awk '{print $3}' | base64)"
  echo ""

  echo "Fire Trigger stockTrigger via wsk cli"
  wsk trigger fire stockTrigger '{"IBM":200}'

  echo "Fire Trigger via curl using HTTP POST"
  curl -d '{ "IBM": "200" }' "https://openwhisk.ng.bluemix.net/api/v1/namespaces/$CURRENT_NAMESPACE/triggers/stockTrigger" -XPOST -H 'Content-Type: application/json' -H "Authorization: Basic $(wsk property get --auth | awk '{print $3}' | base64)"
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