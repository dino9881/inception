#!/bin/bash

echo  mariadb start
apt-get update
apt-get upgrade -y
apt-get install mariadb-server -y
apt-get install vim -y 
service mysql start; sleep 1;
# mysql_install_db --auth-root-authentication-method=normal --datadir=/data
sed -i "s/bind-address/#bind-address/" /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s/password =/password = $MYSQL_ROOT_PASSWORD/g" /etc/mysql/debian.cnf


echo "CREATE DATABASE $MYSQL_DATABASE;" | mysql -u root -p$MYSQL_ROOT_PASSWORD
echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root -p$MYSQL_ROOT_PASSWORD
echo "CREATE USER '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';" | mysql -u root -p$MYSQL_ROOT_PASSWORD
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root -p$MYSQL_ROOT_PASSWORD
echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';" | mysql -u root -p$MYSQL_ROOT_PASSWORD


echo "FLUSH PRIVILEGES;" | mysql -u root




service mysql stop; sleep 1;

echo  mysql finish

exec "$@"
