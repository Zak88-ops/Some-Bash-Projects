# Netdata Monitoring Dashboard Project

A beginner DevOps project to learn the basics of system monitoring using [Netdata](https://github.com/netdata) — a real-time performance and health monitoring tool for Linux systems.

## 📋 Project Goals

- Install Netdata on a Linux system
- Monitor basic system metrics: CPU, memory, and disk I/O
- Access and explore the Netdata web dashboard
- Customize the dashboard configuration
- Set up a custom alert (CPU usage alerts and warning )
- Automate the whole workflow with shell scripts

## 🗂️ Project Structure

```
.
├── setup.sh            # Installs Netdata on the system
├── test_dashboard.sh   # Puts load on the system and tests the dashboard/alerts
├── cleanup.sh           # Uninstalls Netdata and removes related files
└── README.md
```

## 🚀 Usage

### 1. Install Netdata
```bash
chmod +x setup.sh
./setup.sh
```
This downloads and runs the official Netdata kickstart script, installing the agent as a systemd service.

### 2. Verify the install
```bash
sudo systemctl status netdata
```
Netdata should show as `active (running)`.

### 3. Access the dashboard
Open in your browser:
```
http://localhost:19999
```

### 4. Run the test/load script
```bash
chmod +x test_dashboard.sh
./test_dashboard.sh
```
This script:
- Fetches system info from the Netdata API (`/api/v1/info`)
- Checks that CPU and RAM charts are being collected
- Applies a custom config tweak 
- Adds a custom alert (`cpu_usage`) that fires at 80% (warning) and 90% (critical) CPU usage
- Installs `stress-ng` and generates CPU load to test CPU performence trigger the alert 
- Restarts Netdata to apply the new config/alert


### 6. Clean up
```bash
chmod +x cleanup.sh
./cleanup.sh
```
This uninstalls Netdata and removes its config, cache, log, and lib directories from the system.

## ⚙️ Customization Made

- **Update frequency**: changed `update every` from the default (1s) to `2s` in `netdata.conf`, changing chart collection granularity.
- **Custom alert**: added a `cpu_usage_high` health rule in `cpu_usage` that warns at 80% CPU and goes critical at 90%.

## 🔔 Alert Configuration

```ini
alarm: cpu_usage_high
   on: system.cpu
 calc: $user + $system
every: 10s
 warn: $this > 80
 crit: $this > 90
 info: Total CPU utilization is high
   to: sysadmin
```

## 🧠 What I Learned

- How to install and run a monitoring agent as a systemd service
- How Netdata organizes metrics into charts and contexts (`system.cpu`, `system.ram`, etc.)
- How to write custom health alarm rules based on chart values
- How to generate synthetic load (`stress-ng`) to validate monitoring/alerting works end-to-end
- Basics of automating repetitive ops tasks (install/test/cleanup) with shell scripts — a first step toward CI/CD practices

## 📚 References

- [Netdata GitHub](https://github.com/netdata/netdata)
- [Netdata Installer Docs](https://learn.netdata.cloud/docs/agent/packaging/installer)
- [Netdata Health/Alarms Docs](https://learn.netdata.cloud/docs/alerting)

## 📌 Notes / Known Issues

- This was tested on WSL2 (Kali Linux), where `os-release` detection can report as "unknown" — this is cosmetic and doesn't affect metric collection.
- No external notification (email/Slack) is configured — alerts are visible only in the local dashboard and via the API.




## project URL ::
https://roadmap.sh/projects/simple-monitoring-dashboard
