#!/bin/sh


certbot certonly --webroot --staging --agree-tos --email hmj@goatpage.com -w /usr/share/nginx/html -d qrpub.fr -d www.qrpub.fr 

cp -Lfp /etc/letsencrypt/live/qrpub.fr/* /etc/nginx/ssl



