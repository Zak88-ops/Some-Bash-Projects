# my first bash projects 

A collection of Bash scripts for automating everyday Linux server and system administration tasks.

## Scripts

### server-stats.sh
Displays key server health and security stats in one shot :


- Cron job --Automates recurring system tasks via cron — set it and forget it--.
- OS info
- Logged in users
- System uptime
- Disk I/O stats 
- CPU usage 
- Memory usage 
- Top  processes by CPU usage
- Top  processes by memory usage
- Installs, enables, and checks status of `fail2ban` (SSH brute-force protection)
## How It Works ??
--It continuously scans log files (like "/var/log/auth.log"  for SSH) looking for patterns of failed login attempts. When an IP address exceeds a set number of failures within a time window, fail2ban automatically bans that IP — usually by adding a temporary firewall that blocks all traffic from it --
## Usage


## Requirements

- `sysstat` (auto-installed by the script if missing)
- `fail2ban` (auto-installed by the script if missing)

##Getting onto ur server or OS##
#download it #
##execute it 
in ur terminal , 
run these cmds in ur Cli :
   $ chmod +x server-stats.sh
   $ crontab -e
   then add this line "0 8 * * * /path/to/server-stats.sh" then save it 
   $ ./server-stats.sh

>Note: some parts of the script use `sudo` (for installing/enabling fail2ban , sysstat), so you may be prompted for your password.
 
project URL :
https://roadmap.sh/projects/server-stats

This is project "https://roadmap.sh/projects/server-stats" DevOps project

https://roadmap.sh/projects/simple-monitoring-dashboard


