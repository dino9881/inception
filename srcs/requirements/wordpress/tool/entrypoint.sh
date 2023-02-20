#!/bin/bash
echo "WAIT"
sleep 30;
echo wordpress start
apt-get update
apt-get upgrade -y && \
apt-get -y install \
php7.3 \
php-fpm \
php-cli \
wget \
curl \
php-mysql \
php-mbstring \
php-xml \
sendmail \
vim
service php7.3-fpm start; sleep 1;
apt-get install mariadb-client -y
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# # cd /var/www/html
wp core download --allow-root --path=/var/www/html/
wp core config --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --dbprefix=wp_ --allow-root --path=/var/www/html/
wp core install --url=$DOMAIN_NAME --title=inception --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path=/var/www/html/
wp theme install twentytwentythree --activate --allow-root --path=/var/www/html/




# curl -LO https://wordpress.org/latest.tar.gz
# tar xzvf latest.tar.gz
# mv ./wordpress/* /var/www/html/ 
# chown -R www-data:www-data /var/www/html
# rm -r ./wordpress latest.tar.gz
# chmod -R 755 /var/www/html/
# mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '$WORDPRESS_DB_NAME' );/" /var/www/html/wp-config.php
# sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER','$WORDPRESS_DB_USER' );/" /var/www/html/wp-config.php
# sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '$WORDPRESS_DB_PASSWORD' );/" /var/www/html/wp-config.php
# sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', '$WORDPRESS_DB_HOST' );/" /var/www/html/wp-config.php
# echo "define('WP_SITEURL', '$DOMAIN_NAME');" >> /var/www/html/wp-config.php;
# echo "define('WP_HOME', '$DOMAIN_NAME');" >> /var/www/html/wp-config.php;
# echo "define('WP_TITLE', 'inception');" >> /var/www/html/wp-config.php;
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.3/fpm/pool.d/www.conf


service php7.3-fpm stop; sleep 1;

echo wordpress finish


exec "$@"
# tail -f /dev/null