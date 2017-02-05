#!/bin/bash

echo "DOMAIN:"$DOMAIN
echo $TEST

if [ -z "$DOMAIN" ]; then

	echo "Root domain name needed use : -e DOMAIN=mydomain.org -e MOREDOMAINS=www.mydomain.org,blog.mydomain.org"


else
	if [ ! -f /etc/nginx/conf.d/$DOMAIN.conf ]; then
		echo "building  $DOMAIN.conf"
		cp /templates/simple.conf /etc/nginx/conf.d/$DOMAIN.conf
		SERVER_NAME="$DOMAIN ${MOREDOMAINS//,/ }"
		sed -i "s/__SERVER_NAME__/$SERVER_NAME/g" /etc/nginx/conf.d/$DOMAIN.conf
		sed -i "s/__DOMAIN__/$DOMAIN/g" /etc/nginx/conf.d/$DOMAIN.conf
	fi


	if [ ! -d /etc/letsencrypt/live/$DOMAIN ]; then
		LISTDOMAINS=$([ -z $MOREDOMAINS ] && echo "" || echo  "-d ${MOREDOMAINS//,/ -d }")
		EMAIL=$([ -z $EMAIL ] && echo "" || echo "--email $EMAIL") 
		TEST=$([ -z $TEST ] && echo "" || echo "--staging")
		echo $LISTDOMAINS
		echo $EMAIL
		echo $TEST
		certbot certonly --standalone --non-interactive  $TEST --agree-tos $EMAIL -d $DOMAIN $LISTDOMAINS

	fi

	if [ ! -f /etc/letsencrypt/live/$DOMAIN/dhparam.pem ]; then
		openssl dhparam -out /etc/letsencrypt/live/$DOMAIN/dhparam.pem $DH
	fi

	crontab /scripts/crontab
	crond
	
	nginx -g "daemon off;"

fi
