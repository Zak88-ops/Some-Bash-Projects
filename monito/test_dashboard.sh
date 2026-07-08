#!/usr/bin/bash
#Getting infos about ur system (System - DB - Modules - Directories ) and more details informations Hardware references 
curl -s http://localhost:19999
#Or Access to the dashboard via :: 
"http://localhost:19999"
#more infos(like hostname - total disk space - CPU frequency - )  
curl -s http://localhost:19999/api/v1/info > OS-information.txt

#Montoring CPU / memory
curl -s http://localhost:19999/api/v1/charts | grep -o '"system.cpu"' >>monitors.txt
curl -s http://localhost:19999/api/v1/charts | grep -o '"system.ram"' >>monitors.txt

#Config  and customize my Dashboard 
echo "[global] update every = 2" >> /opt/netdata/etc/netdata/netdata.conf

#This is cpu.config contain values for waning an critical values for CPU utilization
#Netdata.conf doesn't contain  any values (Set it by Default)


echo "alarm: cpu_usage_high
   on: system.cpu
 calc: $user + $system
every: 10s
 warn: $this > 80
 crit: $this > 90
 info: Total CPU utilization is high
   to: sysadmin" >> cpu.conf
#Add this block to  
echo cpu.conf >> /opt/netdata/etc/netdata/netdata.conf



#CPU stress tool for test CPU performane 
sudo apt install -y stress-ng
#run it for 30s
stress-ng --timeout 30s 


#then we are going to restart Netdata 
sudo systemctl restart netdata 
