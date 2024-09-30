#!/bin/ash
# Installation script.

DIR=/usr/openwrt-wan-keep-alive
#Check if ncat is installed
NCAT_INSTALLED=$(opkg status ncat|grep "installed")

echo ""
echo "##### OpenWRT wan-keep-alive #####"
echo ""

install_ncat()
{
	echo "Installing ncat (opkg install ncat) ..."
	opkg -V0 update
	opkg install ncat
	echo "ncat is now installed"
}

finish(){
	echo ""
	echo "OpenWRT wan-keep-alive is now installed and ready"
	rm install_owka.sh
}

download_files()
{
	DIR=/usr/openwrt-wan-keep-alive
	mkdir $DIR
 	touch $DIR/log.txt
  	echo "Downloading files from https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master ..."
   	wget -q --show-progress --no-check-certificate --no-cache https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/dns-test.sh -O $DIR/dns-test.sh && chmod +x $DIR/dns-test.sh
 	wget -q --show-progress --no-check-certificate --no-cache https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/wan-keep-alive.sh -O $DIR/wan-keep-alive.sh && chmod +x $DIR/wan-keep-alive.sh
 	wget -q --show-progress --no-check-certificate --no-cache https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/restart-interface.sh -O $DIR/restart-interface.sh && chmod +x $DIR/restart-interface.sh
	wget -q --show-progress --no-check-certificate --no-cache https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/restart-router.sh -O $DIR/restart-router.sh && chmod +x $DIR/restart-router.sh
	wget -q --show-progress --no-check-certificate --no-cache https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/wankeepalive -O /etc/init.d/wankeepalive && chmod +x /etc/init.d/wankeepalive
	echo "..."
	echo "Enabling and starting wankeepalive script ..."
	/etc/init.d/wankeepalive enable && /etc/init.d/wankeepalive start
	finish
}


echo "Checking for ncat package: $NCAT_INSTALLED"
if [ "" = "$NCAT_INSTALLED" ]; then
 	echo "ncat package is not installed"
 	read -p "This will install ncat package as a prerequisite. Do you want to continue (y/n)? " yn
 	case $yn in
 	    [Yy]* ) install_ncat; break;;
 	    [Nn]* ) echo "Installation aborted by user" ; exit;;
 	    * ) echo "Please answer 'y' or 'n'.";;
 	esac
fi

echo ""

while true; do
    read -p "This will download the files into $DIR. Do you want to continue (y/n)? " yn
    case $yn in
        [Yy]* ) download_files; break;;
        [Nn]* ) echo "Installation aborted by user" ; exit;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
done
