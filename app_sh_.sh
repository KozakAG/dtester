#!/bin/bash



SERVER_IP="192.168.63.100"
DB_IP="192.168.63.50"

echo "_______________________________________________prepare var/www/dtapi_____________________________________________"
sleep 5

git clone https://github.com/koseven/koseven.git

sudo mkdir -p /var/www/dtapi/api
sudo cp -r koseven/modules /var/www/dtapi/api
sudo cp -r koseven/system /var/www/dtapi/api
sudo cp koseven/public/index.php /var/www/dtapi/api
chown -R vagrant:vagrant /var/www/dtapi # chown -R www-data:www-data /var/www/dtapi

#sudo cp koseven/public/index.php /var/www/dtapi


# add new host to /etc/apache2/sites-available directory

cat <<EOF > /etc/apache2/sites-available/dtapi.conf
<VirtualHost *:80>
    DocumentRoot /var/www/dtapi
    <Directory /var/www/dtapi>
        AllowOverride All
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF



git clone https://github.com/yurkovskiy/dtapi.git

sudo cp -r dtapi/application /var/www/dtapi/api
sudo cp ./dtapi/.htaccess /var/www/dtapi/api/.htaccess
sudo mkdir -p /var/www/dtapi/api/application/cache/
sudo mkdir -p /var/www/dtapi/api/application/logs/
chmod 733 /var/www/dtapi/api/application/cache
chmod 722 /var/www/dtapi/api/application/logs

sudo sed -i -e "s|'base_url'   => '/',|'base_url'   => '/api/',|g"  /var/www/dtapi/api/application/bootstrap.php
sudo sed -i -e "s|RewriteBase /|RewriteBase /api/|g"  /var/www/dtapi/api/.htaccess

sudo sed -i -e "s|PDO_MySQL|PDO|g"  /var/www/dtapi/api/application/config/database.php
#sudo sed -i -e "s|localhost;dbname=dtapi|10.166.0.5;dbname=dtapi|g"  /var/www/dtapi/api/application/config/database.php
sudo sed -i -e "s|localhost;dbname=dtapi|192.168.63.50;dbname=dtapi|g"  /var/www/dtapi/api/application/config/database.php

# create .htaccess for root directory

cat <<EOF > /var/www/dtapi/.htaccess
RewriteEngine On
# -- REDIRECTION to https (optional):
# If you need this, uncomment the next two commands
# RewriteCond %{HTTPS} !on
# RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}
# --
RewriteCond %{DOCUMENT_ROOT}%{REQUEST_URI} -f [OR]
RewriteCond %{DOCUMENT_ROOT}%{REQUEST_URI} -d

RewriteRule ^.*$ - [L]
RewriteRule ^ index.html
EOF

# Enable web app in Apache, disable default Apache website directory
a2ensite dtapi
a2dissite 000-default
# Enable Apache modules (headers and rewrite)
a2enmod headers
a2enmod rewrite

# Restart Apache to enable new config
systemctl restart apache2


