# ddns-script
A script for updating the IP address to my webserver on Cloudflare. Used on my Raspberry Pi Webserver to enable access to peterlamontagne.com.

## Prerequisites
`jq` is needed for this script and is not installed by default on some distros (including Raspbian). To install, simply run `sudo apt-get install jq`.

## Usage
Fill out the variables at the top of the script. Setting `TTL` to  `1` will make set it as Auto in 
Cloudflare. You can find your `ZONE_ID` on the bottom of the Cloudflare dashboard. You can also generate an API token through Cloudflare for use as the `API_TOKEN`. To find the `RECORD_ID`, the easiest way is to curl a request to another Cloudflare API endpoint like so:
```bash
curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID$/dns_records" -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: application/json" | jq '.'
```

Lastly, the `DNS_NAME` should just be your website domain exactly as it is in the Cloudflare portal.


### Adding to Cron
Reccomend adding to crontab to run hourly and piping the output to a log file.

Example crontab entry:
`0 * * * * ~/ddns-script/script.sh >> log.txt`

Update the log file location as required and use the full file path if not using your user account to run cron.
