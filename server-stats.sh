#!/usr/bin/bash
echo "About ur os ::"
cat /etc/os-release
echo "logged in users ::"
w
echo "Uptime ::"
uptime
echo "more about Disk ::"
#install sysstat 
sudo apt install sysstat
iostat 
echo " Total CPU usage is :: "
top 
echo " Total memory usage is ::"
free -h
echo "Top 5 processes by CPU usage are ::"
ps -eo %cpu --sort=%cpu | head -n 6 
#6 is select top 5 processes the first for the header row 
echo "Top 10 processes by memory usage are ::"
ps -eo %mem --sort=%mem |head -n  11

#failed logins & SSH protection 
#we Use a  tool fail2ban is an open source tool  that protect from brute-force attacks 
#install-it 
sudo apt install -y fail2ban
#enable it 
sudo systemctl enable --now fail2ban
#run it 
sudo fail2ban-client status sshd

