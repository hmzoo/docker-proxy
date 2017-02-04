#!/bin/sh

service nginx stop

certbot certonly --standalone --staging --agree-tos --email hmj@goatpage.com  -d qrpub.fr -d www.qrpub.fr 

#cp -Lfp /etc/letsencrypt/live/qrpub.fr/* /etc/nginx/ssl

#openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048


