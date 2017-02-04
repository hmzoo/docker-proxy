#/bin/sh

mkdir -p /usr/share/nginx/html
mkdir -p /etc/nginx/ssl

cp -rf ../nginx/* /etc/nginx
cp -rf ../html/* /usr/share/nginx/html

openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048




