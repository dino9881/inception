#!/bin/bash
echo "WAIT"
sleep 60;
echo nginx start

apt-get update -y
apt-get upgrade -y
apt-get -y install nginx openssl vim
echo "127.0.0.1 $DOMAIN_NAME" >> /etc/hosts
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt -subj "/C=KR/ST=Seoul/L=Gangnam/O=42Seoul/OU=./CN=jonkim.42.fr/emailAddress=jonkim@student.42seoul.kr"
yes | cp var/www/html/default /etc/nginx/sites-available/default


echo nginx finish

exec "$@"

