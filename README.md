# ddns-script
A script for updating the IP address to my webserver on Cloudflare. Used on my Raspberry Pi Webserver to enable access to peterlamontagne.com.

## Usage
Reccomend adding to crontab to run hourly and piping the output to a log file.

Example crontab entry:
`0 * * * * ~/ddns-script/script.sh >> log.txt`

Update the log file location as required and use the full file path if not using your user account to run cron.
