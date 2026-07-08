#!/usr/bin/bash
echo "Downloading Netdata in ur OS ......"
curl "https://get.netdata.cloud/kickstart.sh" > /tmp/netdata-kickstart.sh && sh /tmp/netdata-kickstart.sh
#OR with wget 
wget -O /tmp/netdata-kickstart.sh https://get.netdata.cloud/kickstart.sh && sh /tmp/netdata-kickstart.sh
