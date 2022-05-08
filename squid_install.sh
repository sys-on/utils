#!/bin/bash
clear
echo "Preparing...";
[[ -d "/etc/squid" ]] && {
service squid stop;
apt-get remove squid -y >/dev/null 2>&1
apt-get purge squid -y >/dev/null 2>&1
rm -rf /etc/squid >/dev/null 2>&1
}
[[ -d "/etc/squid3" ]] && {
service squid3 stop;
apt-get remove squid3 -y >/dev/null 2>&1
apt-get purge squid3 -y >/dev/null 2>&1
rm -rf /etc/squid3 >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
}
clear
#Ask for password if necessary

#Add Trusty Sources
[[ ! -e /etc/apt/sources.list.d/trusty_sources.list ]] && {
touch /etc/apt/sources.list.d/trusty_sources.list >/dev/null 2>&1
echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty main universe" | tee --append /etc/apt/sources.list.d/trusty_sources.list >/dev/null 2>&1
}
[[ $(grep -wc 'Debian' /etc/issue.net) != '0' ]] && {
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5;
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32;
apt install gnupg gnupg2 gnupg1;
apt install dirmngr -y >/dev/null 2>&1
[[ $(apt-key list 2>/dev/null | grep -c 'Ubuntu') == '0' ]] && {
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 >/dev/null 2>&1
}
}
apt update -y >/dev/null 2>&1

#Install Squid
apt install -y squid3=3.3.8-1ubuntu6 squid=3.3.8-1ubuntu6 squid3-common=3.3.8-1ubuntu6

#Install missing init.d script
cd /etc/squid3;
rm -rf squid.conf;
wget https://raw.githubusercontent.com/Andley302/utils/main/squid/squid.conf;
wget https://raw.githubusercontent.com/Andley302/utils/main/squid/payload.txt;
cd /root/
wget https://raw.githubusercontent.com/Andley302/utils/main/squid/squid3
cp squid3 /etc/init.d/
chmod +x /etc/init.d/squid3
update-rc.d squid3 defaults

#Start squid
service squid3 start

#Cleanup
rm squid3

#Print info
clear
echo "====================================="
echo "Squid 3.3.8 is successfully installed!"
echo "Squid's config is located at '/etc/squid3/squid.conf'"
echo "You can start/stop/restart squid by using 'service squid3 start/stop/restart'"
echo "====================================="
