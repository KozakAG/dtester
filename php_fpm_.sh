#!/bin/bash


SERVER_IP="192.168.63.100"
DB_IP="192.168.63.50"
# TODO
DATABASE="dtapi2"
DB_USER_NAME="dtapi"
DB_USER_PSWD="dtapi"

echo "_________________________________________PHP-FPM Install___________________________________________"
sleep 5

prepare_inst(){
#Install Apache and other
    sudo apt update
	sudo apt install -y mc
	sudo apt install -y nano
    sudo apt install apache2 -y
}

install_php(){
	sudo apt install php libapache2-mod-php php-mysql -y

cat <<EOF > /etc/apache2/mods-enabled/dir.conf
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
EOF

	sudo systemctl restart apache2

cat <<EOF > /var/www/html/info.php
<?php
phpinfo();
?>
EOF

sudo systemctl stop apache2

#disable the PHP 7.2, Pre-fork
	sudo a2dismod php7.2
	sudo a2dismod mpm_prefork

	sudo a2enmod mpm_event

	sudo apt install php-fpm -y
	sudo apt install -y libapache2-mod-fcgid  php-mbstring php-xml
	a2enmod headers
	a2enmod rewrite

#enable the php-fpm,enable Apache HTTP proxy module,enable the FastCGI 
	sudo a2enconf php7.2-fpm
	sudo a2enmod proxy
	sudo a2enmod proxy_fcgi

	sudo apachectl configtest
	sudo systemctl restart apache2
}

prepare_inst
install_php