#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 12.18.2
npm install -g @angular/cli@8.3.21 -y

git clone https://github.com/yurkovskiy/IF-105.UI.dtapi.if.ua.io.git
cd IF-105.UI.dtapi.if.ua.io
npm install
###
ng build --prod

sudo cp -r /home/vagrant/IF-105.UI.dtapi.if.ua.io/dist/IF105/* /var/www/dtapi
