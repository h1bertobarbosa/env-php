#!/bin/bash

if [ ! -z $SUBDOMAINS ];
then
  echo "SUBDOMAINS entered, processing"
  for job in $(echo $SUBDOMAINS | tr "," " "); do
    export SUBDOMAINS2="$SUBDOMAINS2 -d "$job"."$URL""
  done
  echo "Sub-domains processed are:" $SUBDOMAINS2
  echo -e "SUBDOMAINS2=\"$SUBDOMAINS2\" URL=\"$URL\"" > /root/domains.conf
else
  echo "No subdomains defined"
  echo -e "URL=\"$URL\"" > /root/domains.conf
fi

if [ ! -d /etc/nginx/keys ];
then
  ln -s /etc/letsencrypt/live/mdt.udv.org.br-0001 /etc/nginx/keys
fi

if [ ! -f /etc/nginx/keys/fullchain.pem ];
then
  /usr/local/letsencrypt.sh
else
  service nginx restart
fi

exec "$@"
