#!/usr/bin/env bash
echo "Please provide root access by entering password below:"
sudo apachectl start;

sudo cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.bak;
sudo sed -i -- 's/#LoadModule rewrite_module/LoadModule rewrite_module/g' /etc/apache2/httpd.conf;
sudo sed -i -- 's/#LoadModule php5_module/LoadModule php5_module/g' /etc/apache2/httpd.conf;
sudo apachectl restart;
grep DocumentRoot httpd.conf;
declare -i brew=0
echo "Is brew installed? y/n?";
read text1
if [[ $text1 = "y" ]]; then
        brew=1
else	
    echo "Would you like to install brew? It is higly recommended that you do.";
    read text2
    if [[ $text3 = "y" ]]; then
        xcode-select --install
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew=1
    else	
    	brew=0
    fi  	
fi
if [[ $brew = 1 ]]; then
    brew install mysql
    echo "Would you like to upgrade to php7.0? y/n?"
    read text3
    if [[ $text = y ]]; then
        brew update && brew upgrade
        brew tap homebrew/dupes
        brew tap homebrew/versions
        brew tap homebrew/homebrew-php
        brew unlink php56 
        brew install php70
    fi
else	
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

fi
# read -s -n 1 key 

echo "export PATH=/usr/local/mysql/bin:$PATH" > ~/.bash_profile
sudo mkdir /var/mysql
sudo ln -s /tmp/mysql.sock /var/mysql/mysql.sock
. ~/.bash_profile 

if [[ $brew = 1 ]]; then
	mysql.server start
else
	sudo /usr/local/mysql/support-files/mysql.server start
fi
