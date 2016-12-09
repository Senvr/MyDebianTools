#!/usr/bin/bash
apt-get -y update && apt-get -y upgrade && apt-get -y install build-essential module-assistant && m-a prepare && sh /media/cdrom0/VBoxLinuxAdditions.run 
apt-get -y install sudo
dpkg --add-architecture i386
apt-get -y install ia32-libs
apt-get -y install lib32gcc1
apt-get -y install lib32ncruses5 lib32z1
dpkg --add-architecture i386 
apt-get -y install libc6:i386 
apt-get -y install curl
apt-get -y install lib32stdc++6
apt-get -y install lib32tinfo5
cat > /etc/network/interface << 'EndOfMessage'  # Quotes prevent expansions in the here-doc
auto lo
iface lo inet loopback
   auto eth0
    iface eth0 inet static
        address 192.168.1.7
        netmask 255.255.255.0
        gateway 192.168.1.1
EndOfMessage
apt-get -y autoremove
apt-get -y clean
apt-get -y install screen
echo "Add your user to vboxsf and sudo, i'd do that for you but you are currently $USER..."
sleep 3
aptitude update
aptitude safe-upgrade
aptitude install apache2 apache2-doc
curl -Is http://localhost | head -1
aptitude -y install mysql-server php5-mysql
mysql_secure_installation
aptitude -y install php5-common libapache2-mod-php5 php5-cli
echo '<?php phpinfo(); ?>' > /var/www/html/info.php

reboot
