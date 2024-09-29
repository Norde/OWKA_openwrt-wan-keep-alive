This is my fork of mchsks's lte-keep-alive scripts for OpenWRT. Thanks for this great work at this place. Please keep in mind this is a quick and dirty fork of an low experienced computer-enthusiast. Ideas and suggestions are very welcome, constructive criticism also.

To install run this via ssh:

	wget --no-check-certificate --no-cache https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/install_openwrt-wan-keep-alive.sh -O install_openwrt-wan-keep-alive.sh && chmod +x install_openwrt-wan-keep-alive.sh && ./install_openwrt-wan-keep-alive.sh

The Major difference to the original:
   Keep Alive script is started as daemon and can be enabled or disabled via LUCI.
   You dont need to use CRON anymore.
   
   Because of the changes the 2 minutes between the connection test are written in the script. If you want to change this you 
   have to edit wwan-keep-alive.sh at line 45.
   
   To prevent reboot loop, wwan-keep-alive.sh waits 3 minutes before reboot if connection fails 4 times.
   
   I changed the server for DNS-tests from 8.8.8.8 (Google) to 1.1.1.1 (Cloudflare) because of my personal preference.
   
   The use of my initscript makes it necessary to place the scripts in /usr/wwan-keep-alive.
   
 Plans for the future:
   Store & read settings like:
   -Logsizes (wwan-keep-alive.sh)
   -Waittimes (wwan-keep-alive.sh)
   -DNS-Test server (dns-test.sh)
   -Interface name (restart-interface.sh)
   from a config file.
   
   Change install.sh to work with my fork.
   
   Write an own readme.
   
   
Plans for a far future:
   Maybe make configuration UCI compatible.
   
   Ceate a LUCI webpage for configuration.
   
   Merge scripts into a single one.
   
   Create an OPKG file to get it work with the software management of OpenWRT.
   
Original README.md:   
# OpenWRT LTE Keep-alive scripts

![OpenWRT logo](https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/images/openwrt.png)
![How it looks](https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/images/screenshot1.png)

**What is this? Long story short.**<br>
If your `WAN` interface using `WWAN/QMI/NCM/3G protocol` with your modem is working but your connection drops from time to time, you have just found the safe heaven. These scripts make sure your router is online, managing your interface or router itself. You would probably find use of it when you need to have working internet in **locations with difficult access**, e.g. cabin in the woods, garage or your house on Seychelles.

**How it works?**<br>
All the scripts run on [ash](https://www.in-ulm.de/~mascheck/various/ash/) which is the basic shell for OpenWRT.
The main script (`internet-keep-alive.sh`) tries to ping Google DNS servers (8.8.8.8) using [Netcat](http://netcat.sourceforge.net/).<br>
- If it fails, it restarts the interface.<br>
- If it fails 4 times in a row, it restarts whole system.<br>
Online/offline results are being logged into `log.txt`, which has a cap of `11000` lines, not to flood the whole space on the device.

**Requirements**<br>
[Netcat package](https://openwrt.org/packages/pkgdata/netcat) The TCP/IP Network R/W Utility. The installer installs this package.

**Installation**<br>
1. Log into the router via SSH and go to the directory where you want to keep the script files.<br>
2. Make sure the router is online, then **run the installer using this command** and follow the instructions:<br>
   `wget -q --no-check-certificate https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/assets/install.sh -O install.sh && chmod +x install.sh && ./install.sh`

Simple, right?<br>

Enjoy ❤️🏠📡📶!
