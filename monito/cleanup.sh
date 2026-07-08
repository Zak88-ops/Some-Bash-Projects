#!/usr/bin/bash
#this CMD for cleanup the system from the Netdata Agent after use 
sh /tmp/netdata-kickstart.sh --uninstall
#Cleanup more 
sudo rm -rf /etc/netdata /var/cache/netdata /var/log/netdata /usr/libexec/netdata /var/lib/netdata


