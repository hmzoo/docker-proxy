#!/bin/sh

apk upgrade 
apk add --update  nginx openssl certbot
setup-timezone -z Europe/Paris
