#!/bin/sh


cp ./renewCert /etc/periodic/daily
cp ./cleanLogs /etc/periodic/monthly
rc-update add crond
rc-service crond start


