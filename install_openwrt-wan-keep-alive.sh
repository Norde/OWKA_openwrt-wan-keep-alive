#!/bin/ash
# Installation script.

DIR=/usr/openwrt-wan-keep-alive

install_ncat()
{
	echo "Installing netcat (opkg install ncat) ..."
    opkg -V0 update
    opkg -V0 install ncat
}

finish(){
	echo ""
    echo "Installation of scripts and PID complete"
    rm install_openwrt-wan-keep-alive.sh
}

download_files()
{
	DIR=/usr/openwrt-wan-keep-alive
	mkdir $DIR
    	touch $DIR/log.txt
  	echo "Downloading files from https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive ..."
   	wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/dns-test.sh -O $DIR/dns-test.sh && chmod +x $DIR/dns-test.sh
 	wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/wan-keep-alive.sh -O $DIR/wwan-keep-alive.sh && chmod +x $DIR/wwan-keep-alive.sh
    	wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/restart-interface.sh -O $DIR/restart-interface.sh && chmod +x $DIR/restart-interface.sh
	wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/restart-router.sh -O $DIR/restart-router.sh && chmod +x $DIR/restart-router.sh
	wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/wankeepalive -O /etc/init.d/wankeepalive && chmod +x /etc/init.d/wankeepalive
    	finish
}

echo ""
echo "OpenWRT wan-keep-alive scripts."

while true; do
    read -p "This will install ncat as a prerequisite. Do you want to continue (y/n)? " yn
    case $yn in
        [Yy]* ) install_ncat; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
done

echo ""

while true; do
    read -p "This will download the files into $DIR. Do you want to continue (y/n)? " yn
    case $yn in
        [Yy]* ) download_files; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
done
