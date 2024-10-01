# OpenWRT wan Keep alive (OWKA) scripts

Another fork of mchsks's lte-keep-alive scripts for OpenWRT.


![OpenWRT](https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/edit/master/images/openwrt2020.png)
![OWKA](https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/edit/master/owka.png)



If for some reason your Internet connection crashes from time to time (buggy ISP's modem, unstable wifi, unstable wwan, unstable router) and a reboot of the network interface or the router itself solves the problem, this script could be very useful!



Script functionality:
- Check whether the router has Internet access by pinging 2 privacy-preserving DNS servers: 9.9.9.9 (Quad9) and 193.110.81.0 (DNS0.EU).
- If the router is offline, restart all network interface (wan, lan and wifi) up to 5 time (with a 45sec wait in between).
- If restarting interface is not enough, reboot the router (with 3min wait to avoid boot loop).
- Event log (with auto-purge to avoid saturating router storage).
- Automatic installation script.
  

Update compare to original and other forks:
- Internet connection integrity is based on pinging 2 dns servers to avoid false positives in the event of failure of one of them.
- Use of ncat package, a much more improved and recent implementation of netcat, instead of the default busybox netcat "compact" or the outdated netcat package.
- The script is launched by a service daemon (etc/inid.d) and can therefore be controlled from the LUCI GUI (Thanks to helplessheadless for this nice improvment).
- The installation script automatically installs the ncat package if required and also activates and starts the daemon service.


## Installation

To install OWKA, run the following command and follow the instructions:

	wget --no-check-certificate https://raw.githubusercontent.com/Norde/openwrt-wan-keep-alive/master/install_owka.sh -O install_owka.sh && chmod +x install_owka.sh && ./install_owka.sh



### Folders

Scripts and logs folder:
/usr/openwrt-wan-keep-alive

Daemon:
/etc/init.d/wankeepalive

   
### Future developments

- Enable customization of parameters via the installation script (installation folder, daemon name, dns, delay between restart, number of trials...)
- Add the option to select between reseting one specific interface or all network.
