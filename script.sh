#!/bin/bash

### Google Domains provides an API to update a DNS
### "Synthetic record". This script updates a record with 
### the script-runner's public IP address, as resolved using a DNS
### lookup.
###
### Google Dynamic DNS: https://support.google.com/domains/answer/6147083
### Synthetic Records: https://support.google.com/domains/answer/6069273

USERNAME=
PASSWORD=
HOSTNAME="raspi.peterlamontagne.com"
DATE=$(date +"%d/%m@%H:%M")


# Resolve current public IP
IP=$( dig +short myip.opendns.com @resolver1.opendns.com )
# Update Google DNS Record
URL="https://${USERNAME}:${PASSWORD}@domains.google.com/nic/update?hostname=${HOSTNAME}&myip=${IP}"
OUTPUT=$(curl -s $URL)

printf "Time:%s  " $DATE >> log.txt
printf "%s  " $OUTPUT >> log.txt
printf "\n\n\n" >> log.txt


