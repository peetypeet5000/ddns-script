#!/bin/bash

### Google Domains provides an API to update a DNS
### "Synthetic record". This script updates a record with 
### the script-runner's public IP address, as resolved using a DNS
### lookup.
###
### Cloudflare API Docs: https://developers.cloudflare.com/api/resources/dns/subresources/records/methods/scan/

ZONE_ID="your_cloudflare_zone_id"
RECORD_ID="your_cloudflare_record_id"
API_TOKEN="your_cloudflare_api_token"
DNS_NAME="your_dns_name"
TTL=120
PROXIED=false


# Resolve current public IP
IP=$( curl --ipv4 -s http://icanhazip.com )

# Request current DNS record from Cloudflare
DNS_RECORD=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json")

# Check if IP has changed
EXISTING_IP=$(echo $DNS_RECORD | jq -r '.result.content')
if [ "$CURRENT_IP" == "$EXISTING_IP" ]; then
    echo "IP has not changed. Exiting."
    exit 0
fi


# Update the DNS record with the new IP
UPDATE_RESPONSE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
     -H "Authorization: Bearer $API_TOKEN" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"A\",\"name\":\"$DNS_NAME\",\"content\":\"$CURRENT_IP\",\"ttl\":$TTL,\"proxied\":$PROXIED}")

# Check if the update was successful
if echo $UPDATE_RESPONSE | jq -e '.success' > /dev/null; then
    echo "DNS record updated successfully to $CURRENT_IP"
    printf "Time:%s  " $DATE
    printf "%s  " $OUTPUT
    printf "\n"
else
    echo "Failed to update DNS record"
    echo $UPDATE_RESPONSE | jq
    exit 1
fi






