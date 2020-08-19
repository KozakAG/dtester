#!/bin/sh

dnf update -y
dnf install nginx -y

firewall-cmd --permanent --add-service=http
firewall-cmd --reload
setenforce 0

cat<<EOF > /etc/nginx/conf.d/lb.conf
upstream app {
  ip_hash;
  server 192.168.100;
  server 192.168.200;
}
server {
        listen 80 default_server;
        listen [::]:80 default_server;
        location / {
            proxy_pass http://app;
        }
}
EOF

sed -i "s|\s*default_server||g" /etc/nginx/nginx.conf

systemctl start nginx
