# 🔍 Nginx Log Analyser

A lightweight Bash CLI tool that parses Nginx access logs and extracts key insights — top requesting IPs, most requested paths, response status code distribution, and basic security threat detection (suspicious 404 scanners).

Part of the [Some-Bash-Projects](https://github.com/Zak88-ops/Some-Bash-Projects) collection, inspired by the [roadmap.sh Nginx Log Analyser project](https://roadmap.sh/projects/nginx-log-analyser).

---

## ✨ Features

- 📊 **Top 5 IP addresses** with the most requests
- 🌐 **Top 5 most requested paths/endpoints**
- 📈 **Top 5 HTTP response status codes**
- 🛡️ **Basic security detection** — top 5 IPs generating the most `404` errors (potential scanners/bots)
- 💾 Exports top-IP results to `report.json`

---

## 📋 Requirements

- A Unix-like environment (Linux, macOS, or WSL)
- Bash
- Standard CLI tools: `awk`, `sort`, `uniq` (pre-installed on virtually all Linux/macOS systems)
- An Nginx access log file in the default combined log format

---

## 🚀 Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/Zak88-ops/Some-Bash-Projects.git
   cd Some-Bash-Projects/nginx
   ```

2. Make the script executable:
   ```bash
   chmod +x main.sh
   ```

3. Run it:
   ```bash
   ./main.sh
   ```

4. When prompted, enter the path to your Nginx log file:
   ```
   Enter the path to ur log file:
   /var/log/nginx/access.log
   ```

5. The script will print:
   - Top 5 IPs by request count
   - Top 5 requested paths
   - Top 5 response status codes
   - Top 5 IPs with the most `404` errors

6. A `report.json` file will be generated in the current directory containing the top-IP results.

---

## 📸 Sample Output

```
Enter the path to ur log file:
access.log

Top 5 IP addresses with the most requests are
192.168.1.10-482 requests
10.0.0.5-317 requests
...

Top 5 mosted requests paths with most requests
/index.html-210 requests
/api/users-145 requests
...

Top 5 responses status codes:
200-1204 requests
404-88 requests
...
```

---

## 🗂️ Project Structure

```
Some-Bash-Projects/
└── nginx/
    ├── main.sh        # Main analysis script
    ├── report.json    # Generated output (top IPs)
    └── README.md
```

---

## 🛠️ How It Works

The script relies on `awk` field parsing over the standard Nginx combined log format:

| Field | Description |
|---|---|
| `$1` | Client IP address |
| `$7` | Requested path |
| `$9` | HTTP status code |

Each metric is computed with the same pipeline pattern:
```bash
awk '{print $FIELD}' log_file | sort | uniq -c | sort -rn | head -n 5
```

---

## 🗺️ Roadmap / Ideas for Improvement

- [ ] Add support for custom log formats (not just default Nginx combined format)
- [ ] Add a `--top N` flag to customize how many results are shown
- [ ] Add date/time range filtering
- [ ] Export full report (not just top IPs) to JSON
- [ ] Add unit tests with sample log fixtures

---

## 📚 Related Project

This project is part of the [DevOps Roadmap](https://roadmap.sh/devops) learning path.

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 👤 Author

**Zaki Jamel** — [@Zak88-ops](https://github.com/Zak88-ops)
URL : https://roadmap.sh/projects/nginx-log-analyser
