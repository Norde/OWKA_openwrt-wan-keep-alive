#!/bin/ash
# Installation script.

DIR=/usr/openwrt-wan-keep-alive
#Check if ncat is installed
NCAT_INSTALLED=$(opkg status ncat|grep "installed")

echo ""
echo "##### OpenWRT wan-keep-alive scripts #####"
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
    echo "Installation of scripts and PID complete"
    rm install_openwrt-wan-keep-alive.sh
}

download_files()
{
    DIR=/usr/openwrt-wan-keep-alive
    mkdir $DIR
    touch $DIR/log.txt
    echo "Downloading files from https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master ..."
    wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/dns-test.sh -O $DIR/dns-test.sh && chmod +x $DIR/dns-test.sh
    wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/wan-keep-alive.sh -O $DIR/wwan-keep-alive.sh && chmod +x $DIR/wwan-keep-alive.sh
    wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/restart-interface.sh -O $DIR/restart-interface.sh && chmod +x $DIR/restart-interface.sh
    wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/restart-router.sh -O $DIR/restart-router.sh && chmod +x $DIR/restart-router.sh
    wget -q --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/wankeepalive -O /etc/init.d/wankeepalive && chmod +x /etc/init.d/wankeepalive
    finish
}


echo "Checking for ncat package: $NCAT_INSTALLED"
if [ "" = "$NCAT_INSTALLED" ]; then
    echo "ncat package is not installed"
    read -p "This will install ncat package as a prerequisite. Do you want to continue (y/n)?" yn
    case $yn in
        [Yy]* ) install_ncat; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
fi

echo ""

while true; do
    read -p "This will download the files into $DIR. Do you want to continue (y/n)? " yn
    case $yn in
        [Yy]* ) download_files; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
done
