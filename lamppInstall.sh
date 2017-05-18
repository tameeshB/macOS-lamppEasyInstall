#!/usr/bin/env bash
echo "Please provide root access by entering password below:"
sudo apachectl start;

sudo cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.bak;
sudo sed -i -- 's/#LoadModule rewrite_module/LoadModule rewrite_module/g' /etc/apache2/httpd.conf;
sudo sed -i -- 's/#LoadModule php5_module/LoadModule php5_module/g' /etc/apache2/httpd.conf;
sudo apachectl restart;
grep DocumentRoot httpd.conf;
open https://jason.pureconcepts.net/2015/10/install-apache-php-mysql-mac-os-x-el-capitan/#install-mysql-on-mac-os-x-el-capitan;
declare -i flow=0
while [ $flow -lt 1 ]
do
    echo "Enter y and hit enter after Done installing mysql";
    read text
    if [[ $text = "y" ]]; then
        flow=`expr $flow + 1`
    else	
    	flow=0
    fi
done 
# read -s -n 1 key 

echo "export PATH=/usr/local/mysql/bin:$PATH" > ~/.bash_profile
sudo mkdir /var/mysql
sudo ln -s /tmp/mysql.sock /var/mysql/mysql.sock
