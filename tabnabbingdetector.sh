#!/bin/bash
mkdir responsebody
CURRENT_PATH=$(pwd)
xforwardedfor="rockysec"   ## PUT YOUR OWN TAG X-FORWARDED-FOR
for x in $(cat $1)
do
        NAME=$(echo $x | awk -F/ '{print $3}')
        curl --insecure -s -X GET -H "X-Forwarded-For: $xforwardedfor" -L $x > "$CURRENT_PATH/responsebody/$NAME"
done

#### SEARCH POTENTIAL VULNERABILTY TABNABBING IN SOURCE CODE FILES ####
VULN="_blank"
BOLD="\e[1m"
NORMAL="\e[0m"
GREEN="\e[32m"
RED="\e[30m"
for domain in $(ls responsebody)
 do
  echo -e "\n${BOLD}${GREEN}${domain}${NORMAL}"
  RES=$(cat responsebody/$domain | grep -E "${VULN}")
  if [ $(echo $RES | wc -c) -le 1 ]
  then
   echo -e "${BOLD}${RED}No results found${NORMAL}"
  else
   echo $RES
  fi
 done
