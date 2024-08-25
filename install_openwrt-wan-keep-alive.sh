#!/bin/ash
# Installation script.

DIR=/usr/wwan-keep-alive

install_netcat()
{
	echo "Installing netcat (opkg install netcat) ..."
    opkg -V0 update
    opkg -V0 install netcat
}

finish(){
	echo ""
    echo "NICE ;)"
#    echo "There are 2 important steps to finish this setup:"
#    echo ""
#    echo "1. Make sure this line is in the cron. To open the cron editor, run: crontab -e"
#    echo "   */2 * * * * $DIR/internet-keep-alive.sh"
#    echo ""  
#    echo "2. The interface representing the LTE connection is set to 'wwan'."
#    echo "   To change the interface, please edit the line INTERFACE='wwan' in the 'restart-interface.sh'."
    echo ""
    echo "Enjoy!"

    rm install.sh
}

download_files()
{
	DIR=/usr/wwan-keep-alive
	mkdir $DIR
    	touch $DIR/log.txt
  	echo "Downloading files from https://raw.githubusercontent.com/helplessheadless/openwrt-lte-keep-alive ..."
   	wget -q --no-check-certificate https://raw.githubusercontent.com/helplessheadless/openwrt-lte-keep-alive/master/dns-test.sh -O $DIR/dns-test.sh && chmod +x $DIR/dns-test.sh
 	wget -q --no-check-certificate https://raw.githubusercontent.com/helplessheadless/openwrt-lte-keep-alive/master/wwan-keep-alive.sh -O $DIR/wwan-keep-alive.sh && chmod +x $DIR/wwan-keep-alive.sh
    	wget -q --no-check-certificate https://raw.githubusercontent.com/helplessheadless/openwrt-lte-keep-alive/master/restart-interface.sh -O $DIR/restart-interface.sh && chmod +x $DIR/restart-interface.sh
	wget -q --no-check-certificate https://raw.githubusercontent.com/helplessheadless/openwrt-lte-keep-alive/master/restart-router.sh -O $DIR/restart-router.sh && chmod +x $DIR/restart-router.sh
	wget -q --no-check-certificate https://raw.githubusercontent.com/helplessheadless/openwrt-lte-keep-alive/master/wwankeepalive -O /etc/init.d/wwankeepalive && chmod +x /etc/init.d/wwankeepalive
    	finish
}

echo ""
echo "OpenWRT Keep-alive scripts."

while true; do
    read -p "This will install netcat as a prerequisite. Do you want to continue (y/n)? " yn
    case $yn in
        [Yy]* ) install_netcat; break;;
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
