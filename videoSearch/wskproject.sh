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
  echo -e "${YELLOW}Usage: $0 [--install, --update, --reinstall, --uninstall]${NC}"
  echo -e "${YELLOW}Usage: $0 --test <query>${NC}"
}

function install() {
  echo -e "${YELLOW}Installing OpenWhisk project"

  echo "Creating triggers"
  wsk trigger create searchVideoTrigger

  echo "Creating actions"
  wsk action create searchVideoAction action.js

  echo "Creating rules"
  wsk rule create --enable searchVideoRule searchVideoTrigger searchVideoAction

  echo -e "${GREEN}Install Complete${NC}"
  #wsk list
}

function uninstall() {
  echo -e "${RED}Uninstalling OpenWhisk project"
  
  echo "Removing rules..."
  wsk rule disable searchVideoRule
  wsk rule delete searchVideoRule

  echo "Removing actions..."
  wsk action delete searchVideoAction

  echo "Removing triggers"
  wsk trigger delete searchVideoTrigger

  echo -e "${GREEN}Uninstall Complete${NC}"
  #wsk list
}

function update() {
  echo -e "${YELLOW}Updating OpenWhisk project"
  
  echo "Update actios rules..."
  wsk action update searchVideoAction action.js

  echo -e "${GREEN}Update Complete${NC}"
  #wsk list
}

function test() {
  local query=$1

  echo -e "${YELLOW}Testing OpenWhisk project"

  echo "Invoke Action directly via wsk cli"
  wsk action invoke searchVideoAction -b -r \
  -p query $query
  
  echo "Fire Trigger searchVideoTrigger via wsk cli"
  wsk trigger fire searchVideoTrigger \
  -p query $query

  echo -e "${GREEN}Tests Complete${NC}"
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
test $2 $3 $4 $5
;;
* )
usage
;;
esac