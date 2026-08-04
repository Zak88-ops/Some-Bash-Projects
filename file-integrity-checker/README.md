# File Integrity Checker (FIC)

A lightweight, zero-dependency Bash utility designed to monitor and verify the integrity of application log files. By utilizing cryptographic hashing (SHA-256), this tool detects unauthorized changes, file tampering, or accidental modifications in critical log directories and files.

## Features

* **Flexible Targets:** Accepts both individual log files or entire directories.
* **SHA-256 Hashing:** Generates cryptographic checksums to detect byte-level modifications.
* **Baseline Management:** Stores file states in `hashes.txt` for future comparisons.
* **Tamper Detection:** Quickly checks stored checksums against live files and alerts on discrepancies.
* **Manual Re-initialization:** Supports updating checksums when legitimate system changes occur.

## Prerequisites

* **OS:** Linux, macOS, or Windows Subsystem for Linux (WSL)
* **Shell:** Bash (version 4.0 or higher recommended)
* **Core Utilities:** `sha256sum`, `grep`, `awk`, `find`, `realpath`

## Installation

1. Clone the repository:
   ```bash
   git clone [https://github.com/your-username/FIC.git](https://github.com/your-username/FIC.git)
   cd FIC
