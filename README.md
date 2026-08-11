<div align="center">

# 🐧 Some-Bash-Projects

**A growing collection of Bash scripts for automating everyday Linux server administration, monitoring, and log analysis tasks.**

[![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black)](https://www.linux.org/)
[![roadmap.sh](https://img.shields.io/badge/roadmap.sh-DevOps-blueviolet)](https://roadmap.sh/devops)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Built while following the [roadmap.sh DevOps path](https://roadmap.sh/devops) — one project at a time.

</div>

---

## 📂 Projects

| Project | Description | Docs |
|---|---|---|
| 🖥️ **[server-stats.sh](./server-stats.sh)** | Displays key server health & security stats in one shot — CPU, memory, disk I/O, uptime, top processes — plus automated `fail2ban` setup for SSH brute-force protection. | [roadmap.sh project](https://roadmap.sh/projects/server-stats) |
| 📊 **[monito/](./monito)** | A simple server monitoring dashboard for tracking live system metrics. | [roadmap.sh project](https://roadmap.sh/projects/simple-monitoring-dashboard) |
| 🔍 **[nginx-log-analyser/](./nginx-log-analyser)** | Parses Nginx access logs to surface top IPs, top requested paths, status code breakdowns, and basic security threat detection (404 scanners). | [Full README](./nginx-log-analyser/README.md) · [roadmap.sh project](https://roadmap.sh/projects/nginx-log-analyser) |

---

## 🖥️ server-stats.sh

Displays key server health and security stats in one shot:

- OS info
- Logged in users
- System uptime
- Disk I/O stats
- CPU usage
- Memory usage
- Top processes by CPU usage
- Top processes by memory usage
- Installs, enables, and checks status of `fail2ban` (SSH brute-force protection)
- Automates recurring checks via **cron** — set it and forget it

### How fail2ban works here
It continuously scans log files (like `/var/log/auth.log` for SSH) looking for patterns of failed login attempts. When an IP address exceeds a set number of failures within a time window, `fail2ban` automatically bans that IP — usually by adding a temporary firewall rule that blocks all traffic from it.

### Requirements
- `sysstat` (auto-installed by the script if missing)
- `fail2ban` (auto-installed by the script if missing)

### Usage
```bash
# Make it executable
chmod +x server-stats.sh

# (Optional) Run it automatically every day at 8 AM via cron
crontab -e
# add this line, save, and exit:
0 8 * * * /path/to/server-stats.sh

# Run it manually
./server-stats.sh
```

> **Note:** some parts of the script use `sudo` (for installing/enabling `fail2ban` and `sysstat`), so you may be prompted for your password.

**Project reference:** [roadmap.sh/projects/server-stats](https://roadmap.sh/projects/server-stats)

---

## 📊 monito

A lightweight monitoring dashboard project for tracking live server metrics from the command line.

📄 Full documentation: [`monito/README.md`](./monito/README.md)

**Project reference:** [roadmap.sh/projects/simple-monitoring-dashboard](https://roadmap.sh/projects/simple-monitoring-dashboard)

---

## 🔍 nginx-log-analyser

A Bash CLI tool that parses Nginx access logs and extracts:

- Top 5 IP addresses with the most requests
- Top 5 most requested paths
- Top 5 HTTP response status codes
- Top 5 IPs generating the most `404` errors (basic scanner/bot detection)

📄 Full documentation: [`nginx-log-analyser/README.md`](./nginx-log-analyser/README.md)

**Project reference:** [roadmap.sh/projects/nginx-log-analyser](https://roadmap.sh/projects/nginx-log-analyser)
https://roadmap.sh/projects/file-integrity-checker
---

## 🗺️ Roadmap — Upcoming Projects

- [ ] Log Archive Tool
- [ ] SSH Remote Server Setup
- [ ] Basic Dockerfile
- [ ] CI/CD pipeline with GitHub Actions

Following the full [DevOps roadmap](https://roadmap.sh/devops) project by project.

---

## 📄 License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for details.

---

<div align="center">

**Author:** [@Zak88-ops](https://github.com/Zak88-ops)

⭐ If any of these scripts helped you, consider giving the repo a star!

</div>
