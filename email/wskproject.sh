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
  echo -e "${YELLOW}Usage: $0 --test <username> <password> <to> <subject> <text>${NC}"
}

function install() {
  echo -e "${YELLOW}Installing OpenWhisk project"

  echo "Creating triggers"
  wsk trigger create sendEmailTrigger

  echo "Creating actions"
  wsk action create sendEmailAction sendEmail.js

  echo "Creating rules"
  wsk rule create --enable sendEmailRule sendEmailTrigger sendEmailAction

  echo -e "${GREEN}Install Complete${NC}"
  #wsk list
}

function uninstall() {
  echo -e "${RED}Uninstalling OpenWhisk project"
  
  echo "Removing rules..."
  wsk rule disable sendEmailRule
  wsk rule delete sendEmailRule

  echo "Removing actions..."
  wsk action delete sendEmailAction

  echo "Removing triggers"
  wsk trigger delete sendEmailTrigger

  echo -e "${GREEN}Uninstall Complete${NC}"
  #wsk list
}

function update() {
  echo -e "${YELLOW}Updating OpenWhisk project"
  
  echo "Update actios rules..."
  wsk action update sendEmail sendEmail.js

  echo -e "${GREEN}Update Complete${NC}"
  #wsk list
}

function test() {
  local username=$1
  local password=$2
  local to=$3
  local subject=$4
  local text=$5

  echo -e "${YELLOW}Testing OpenWhisk project"

  echo "Invoke Action directly via wsk cli"
  wsk action invoke sendEmailAction -b -r \
  -p username $username \
  -p password $password \
  -p subject $subject \
  -p to $to \
  -p from $username \
  -p text $text
  
  echo "Fire Trigger sendEmailTrigger via wsk cli"
  wsk trigger fire sendEmailTrigger \
  -p username $username \
  -p password $password \
  -p subject $subject \
  -p to $to \
  -p from $username \
  -p text $text

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