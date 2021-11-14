#!/bin/sh
# renew 'lets encrypt certificates'.
# ideally called every 2.5 months or so from cronjob

if [ "$(whoami)" != root ]; then printf "%s\n" "must run as root."; exit; fi

# certbot needs port 80 to be available for the protocol renewal.
systemctl stop lighttpd

printf "%s\n" "... Shutting down httpd" && sleep 5
certbot renew

systemctl start lighttpd
