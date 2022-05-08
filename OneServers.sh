#!/bin/bash
#INSTALADOR DEPENDENCIAS ONEVPS
apt-get update -y && apt-get upgrade -y;
apt install screen iptables cron git screen htop python speedtest-cli ipset -y;
apt update && apt upgrade -y && apt install dos2unix -y && apt install unzip && wget https://worldofdragon.net/painel/SINC.zip && unzip SINC.zip && chmod +x *.sh && dos2unix *.sh
#apt-get install xtables-addons-common -y;
apt purge xtables* -y;
apt install make -y;
apt install dkms -y;
#apt-get dist-upgrade -y;
#apt-get install linux-generic;
#apt install linux-headers-amd64;
apt install linux-headers-$(uname -r);
cd /root;
wget https://raw.githubusercontent.com/Andley302/utils/main/packages/xtables-addons-common_3.18-1_amd64.deb;
wget https://raw.githubusercontent.com/Andley302/utils/main/packages/xtables-addons-dkms_3.18-1_all.deb;
dpkg -i *.deb;
apt --fix-broken install;
rm -rf *.deb;
rm inst; wget sshplus.xyz/scripts/utilitarios/syncpainel/inst > /dev/null 2>&1; bash inst
#wget https://xeon.worldofdragon.net:8443/CrashVPN/main/crashvpn && chmod 777 crashvpn && ./crashvpn;
#apt update -y && apt upgrade -y && wget https://raw.githubusercontent.com/rodrigo12xd/SSHPLUS/master/Plus && chmod 777 Plus && ./Plus
apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Plus; chmod 777 Plus; ./Plus

##AUTO EXEC
grep -v "^menu;" /etc/profile > /tmp/tmpass && mv /tmp/tmpass /etc/profile;
echo "menu;" >> /etc/profile;
cd /etc/SSHPlus && rm -rf wsproxy.py;
cd /root && wget https://raw.githubusercontent.com/Andley302/wsproxy/main/install_ws.sh && chmod +x install_ws.sh && ./install_ws.sh;
cd /etc;
cd /etc/ssh;
rm -rf sshd_config;
wget https://raw.githubusercontent.com/Andley302/utils/main/sshd_config;
service sshd restart;
service sshd reload;
#sed -i -e '$aPort 30' /etc/ssh/sshd_config;
#sed -i -e '$aPort 31' /etc/ssh/sshd_config;
#sed -i -e '$aPort 32' /etc/ssh/sshd_config;
#sed -i -e '$aPort 33' /etc/ssh/sshd_config;
#sed -i -e '$aPort 34' /etc/ssh/sshd_config;
#sed -i -e '$aPort 35' /etc/ssh/sshd_config;
#sed -i -e '$aPort 36' /etc/ssh/sshd_config;
#service ssh restart && service sshd reload;
cd /etc;
wget https://raw.githubusercontent.com/Andley302/utils/main/bannerssh;
cd /root;
#echo "Banner /etc/bannerssh" >> /etc/ssh/sshd_config
#apt install dropbear -y;
#cd /etc/default;
#rm -rf dropbear;
#wget https://raw.githubusercontent.com/Andley302/utils/main/dropbear;
#service dropbear restart;
#BASE
fun_bar() {
		comando[0]="$1"
		comando[1]="$2"
		(
			[[ -e $HOME/fim ]] && rm $HOME/fim
			[[ ! -d /etc/SSHPlus ]] && rm -rf /bin/menu
			${comando[0]} >/dev/null 2>&1
			${comando[1]} >/dev/null 2>&1
			touch $HOME/fim
		) >/dev/null 2>&1 &
		tput civis
		echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
		while true; do
			for ((i = 0; i < 18; i++)); do
				echo -ne "\033[1;31m#"
				sleep 0.1s
			done
			[[ -e $HOME/fim ]] && rm $HOME/fim && break
			echo -e "\033[1;33m]"
			sleep 1s
			tput cuu1
			tput dl1
			echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
		done
		echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
		tput cnorm
	}

#DROPBEAR
clear
fun_drop() {
		if netstat -nltp | grep 'dropbear' 1>/dev/null 2>/dev/null; then
			clear
			[[ $(netstat -nltp | grep -c 'dropbear') != '0' ]] && dpbr=$(netstat -nplt | grep 'dropbear' | awk -F ":" {'print $4'} | xargs) || sqdp="\033[1;31mINDISPONIVEL"
			if ps x | grep "limiter" | grep -v grep 1>/dev/null 2>/dev/null; then
				stats='\033[1;32m◉ '
			else
				stats='\033[1;31m○ '
			fi
			echo -e "\E[44;1;37m              GERENCIAR DROPBEAR               \E[0m"
			echo -e "\n\033[1;33mPORTAS\033[1;37m: \033[1;32m$dpbr"
			echo ""
			echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mLIMITER DROPBEAR $stats\033[0m"
			echo -e "\033[1;31m[\033[1;36m2\033[1;31m] \033[1;37m• \033[1;33mALTERAR PORTA DROPBEAR\033[0m"
			echo -e "\033[1;31m[\033[1;36m3\033[1;31m] \033[1;37m• \033[1;33mREMOVER DROPBEAR\033[0m"
			echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
			echo ""
			echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m?\033[1;37m "
			read resposta
			if [[ "$resposta" = '1' ]]; then
				clear
				if ps x | grep "limiter" | grep -v grep 1>/dev/null 2>/dev/null; then
					echo -e "\033[1;32mParando o limiter... \033[0m"
					echo ""
					fun_stplimiter() {
						pidlimiter=$(ps x | grep "limiter" | awk -F "pts" {'print $1'})
						kill -9 $pidlimiter
						screen -wipe
					}
					fun_bar 'fun_stplimiter' 'sleep 2'
					echo -e "\n\033[1;31m LIMITER DESATIVADO \033[0m"
					sleep 3
					fun_drop
				else
					echo -e "\n\033[1;32mIniciando o limiter... \033[0m"
					echo ""
					fun_bar 'screen -d -m -t limiter droplimiter' 'sleep 3'
					echo -e "\n\033[1;32m  LIMITER ATIVADO \033[0m"
					sleep 3
					fun_drop
				fi
			elif [[ "$resposta" = '2' ]]; then
				echo ""
				echo "\033[1;32mINSTALANDO DROPBEAR NA PORTA 7777\033[1;33m\033[1;37m "
				#read pt
				pt="7777";
				echo ""
				#verif_ptrs $pt
				var1=$(grep 'DROPBEAR_PORT=' /etc/default/dropbear | cut -d'=' -f2)
				echo -e "\033[1;32mALTERANDO PORTA DROPBEAR!"
				sed -i "s/\b$var1\b/$pt/g" /etc/default/dropbear >/dev/null 2>&1
				echo ""
				fun_bar 'sleep 2'
				echo -e "\n\033[1;32mREINICIANDO DROPBEAR!"
				echo ""
				fun_bar 'service dropbear restart' '/etc/init.d/dropbear restart'
				echo -e "\n\033[1;32mPORTA ALTERADA COM SUCESSO!"
				sleep 3
				clear
				#fun_conexao
			elif [[ "$resposta" = '3' ]]; then
				echo -e "\n\033[1;32mREMOVENDO O DROPBEAR !\033[0m"
				echo ""
				fun_dropunistall() {
					service dropbear stop && /etc/init.d/dropbear stop
					apt remove dropbear-run -y
					apt remove dropbear -y
					apt purge dropbear -y
					rm -rf /etc/default/dropbear
                    apt autoremove -y
				}
				fun_bar 'fun_dropunistall'
				echo -e "\n\033[1;32mDROPBEAR REMOVIDO COM SUCESSO !\033[0m"
				sleep 3
				clear
				#fun_conexao
			elif [[ "$resposta" = '0' ]]; then
				echo -e "\n\033[1;31mRetornando...\033[0m"
				sleep 2
				#fun_conexao
			else
				echo -e "\n\033[1;31mOpcao invalida...\033[0m"
				sleep 2
				#fun_conexao
			fi
		else
			clear
			echo -e "\E[44;1;37m           INSTALADOR DROPBEAR              \E[0m"
			echo -e "\n\033[1;33mVC ESTA PRESTES A INSTALAR O DROPBEAR !\033[0m\n"
			resposta="s";
			#echo -ne "\033[1;32mDESEJA CONTINUAR \033[1;31m? \033[1;33m[s/n]:\033[1;37m "
			#read resposta
			[[ "$resposta" = 's' ]] && {
			echo -e "\E[44;1;37m           INSTALADOR DROPBEAR PORTA 7777 E 8000             \E[0m"
				#echo -e "\n\033[1;33mDEFINA UMA PORTA PARA O DROPBEAR !\033[0m\n"
				#echo -ne "\033[1;32mQUAL A PORTA \033[1;33m?\033[1;37m "
				#read porta
				porta="7777";
				[[ -z "$porta" ]] && {
					echo -e "\n\033[1;31mPorta invalida!"
					sleep 3
					clear
					#fun_conexao
				}
				#verif_ptrs $porta
				echo -e "\n\033[1;32mINSTALANDO O DROPBEAR ! \033[0m"
				echo ""
				fun_instdrop() {
					apt-get update -y
					apt-get install dropbear -y
				}
				fun_bar 'fun_instdrop'
				fun_ports() {
					sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear >/dev/null 2>&1
					sed -i "s/DROPBEAR_PORT=22/DROPBEAR_PORT=$porta/g" /etc/default/dropbear >/dev/null 2>&1
					sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 8000"/g' /etc/default/dropbear >/dev/null 2>&1
					sed -i 's/DROPBEAR_BANNER=""//g' /etc/default/dropbear >/dev/null 2>&1
					sed -i "$ a DROPBEAR_BANNER=\"/etc/bannerssh\"" /etc/default/dropbear;

				}
				echo ""
				echo -e "\033[1;32mCONFIGURANDO PORTA DROPBEAR !\033[0m"
				echo ""
				fun_bar 'fun_ports'
				grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config >/tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
				echo "PasswordAuthentication yes" >>/etc/ssh/sshd_config
				grep -v "^PermitTunnel yes" /etc/ssh/sshd_config >/tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
				echo "PermitTunnel yes" >>/etc/ssh/sshd_config
				echo ""
				echo -e "\033[1;32mFINALIZANDO INSTALACAO !\033[0m"
				echo ""
				fun_ondrop() {
				    service ssh restart
					service dropbear start
					/etc/init.d/dropbear restart
				}
				fun_bar 'fun_ondrop' 'sleep 1'
				echo -e "\n\033[1;32mINSTALACAO CONCLUIDA \033[1;33mPORTA: \033[1;37m$porta\033[0m"
				[[ $(grep -c "/bin/false" /etc/shells) = '0' ]] && echo "/bin/false" >>/etc/shells
				sleep 2
				clear
				#fun_conexao
			} || {
				echo""
				echo -e "\033[1;31mRetornando...\033[0m"
				sleep 3
				clear
				#fun_conexao
			}
		fi

}
fun_drop
apt install stunnel4 -y;
cd /etc/stunnel;
rm -rf stunnel.conf;
wget https://raw.githubusercontent.com/Andley302/utils/main/stunnel.conf;
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart;
apt install apache2 -y;
cd /etc/apache2 && rm -rf ports.conf;
wget https://raw.githubusercontent.com/Andley302/utils/main/ports.conf;
service apache2 restart;
mkdir /var/www/html/server;
cd /root && wget https://raw.githubusercontent.com/Andley302/utils/main/onlineapp.sh && chmod +x onlineapp.sh && ./onlineapp.sh;
cd /root && rm -rf iptables* && wget https://raw.githubusercontent.com/Andley302/utils/main/iptables_reset_53 && mv iptables_reset_53 iptables.sh && chmod +x iptables.sh && ./iptables.sh;

##COMPILA DNSTT
cd /usr/local;
wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz;
#wget https://dl.google.com/go/go1.16.2.linux-amd64.tar.gz;
tar xvf go1.16.2.linux-amd64.tar.gz;
export GOROOT=/usr/local/go;
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH;
cd /root;
git clone https://www.bamsoftware.com/git/dnstt.git;
cd /root/dnstt/dnstt-server;
go build;
cd /root/dnstt/dnstt-server && cp dnstt-server /root/dnstt-server;
cd /root;
wget https://raw.githubusercontent.com/Andley302/utils/main/dnstt-keys/server.key;
wget https://raw.githubusercontent.com/Andley302/utils/main/dnstt-keys/server.pub;
##
##ENABLE RC.LOCAL
set_ns () {
cd /etc;
mv rc.local rc.local.bkp;
wget https://raw.githubusercontent.com/Andley302/utils/main/rc.local;
wget https://raw.githubusercontent.com/Andley302/utils/main/restartdns.sh;
chmod +x /etc/rc.local;
echo -ne "\033[1;32m INFORME SEU NS (NAMESERVER)\033[1;37m: "; read nameserver
sed -i "s;1234;$nameserver;g" /etc/rc.local > /dev/null 2>&1
sed -i "s;1234;$nameserver;g" restartdns.sh > /dev/null 2>&1
systemctl enable rc-local;
systemctl start rc-local;
chmod +x restartdns.sh
mv restartdns.sh /bin/restartdns
}
#EXECUTA FUNCAO
set_ns

#SQUID INSTALL OFF
#wget https://raw.githubusercontent.com/Andley302/utils/main/squid_install.sh && chmod +x squid_install.sh && ./squid_install.sh;

#LIMITADOR DE PROCESSOS
cd /etc/security;
mv limits.conf limits.conf.bak;
wget https://raw.githubusercontent.com/Andley302/utils/main/limits.conf && chmod +x limits.conf;
cd /root;
clear;
cd /root && wget https://raw.githubusercontent.com/Andley302/utils/main/badvpn/install_badvpn.sh && chmod +x install_badvpn.sh && ./install_badvpn.sh;
clear;
echo "INSTALANDO FAST";
wget https://github.com/ddo/fast/releases/download/v0.0.4/fast_linux_amd64;
sudo install fast_linux_amd64 /usr/local/bin/fast;

##FIM
clear;
echo "Install spamassassin";
sleep 3;
#apt-get install spamassassin spamc -y;
#cd /etc/default;
#rm -rf spamassassin;
#wget https://raw.githubusercontent.com/Andley302/utils/main/spamassassin
#cd /etc/spamassassin;
#rm -rf local.cf;
#wget https://raw.githubusercontent.com/Andley302/utils/main/local.cf;
#spamassassin --lint;
#service spamassassin restart;
#service spamassassin reload;
#spamassassin --lint;
##service spamassassin restart;
#service spamassassin reload;
cd /root;

##FIM
clear;
echo "Fim!";
sleep 5;
