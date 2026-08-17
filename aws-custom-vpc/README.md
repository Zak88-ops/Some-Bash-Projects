# ☁️ Custom VPC Infrastructure Project

> Building a production-style Virtual Private Cloud (VPC) from scratch — implemented twice: once on **LocalStack** (local AWS simulation) for practice, and once on **OpenScaler** (real Algerian cloud provider) for a live, working deployment.

[![Status](https://img.shields.io/badge/status-completed-brightgreen)]()
[![Stack](https://img.shields.io/badge/stack-AWS%20CLI%20%7C%20LocalStack%20%7C%20OpenScaler-blue)]()
[![License](https://img.shields.io/badge/license-Educational-lightgrey)]()

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Prerequisites](#-prerequisites)
- [Part 1 — LocalStack Implementation](#-part-1--localstack-implementation)
- [Part 2 — OpenScaler Implementation (Real Cloud)](#-part-2--openscaler-implementation-real-cloud)
- [Verification](#-verification)
- [Resource Reference](#-resource-reference)
- [Cleanup](#-cleanup)
- [Key Concepts Learned](#-key-concepts-learned)
- [Real-World Use Cases](#-real-world-use-cases)
- [Roadmap & Next Steps](#-roadmap--next-steps)
- [Author](#-author)

---

## 🧭 Overview

This project demonstrates how to design and provision an isolated cloud network — a **Virtual Private Cloud (VPC)** — including subnetting, routing, internet access, firewall rules, and a running compute instance.

| Aspect | Details |
|---|---|
| **Networking concepts** | CIDR blocks, public/private subnets, routing, NAT/IGW |
| **Security** | Security Groups following the Least Privilege principle |
| **Compute** | A VM/EC2 instance launched inside the public subnet |
| **Environments** | LocalStack (simulation) → OpenScaler (real Algerian cloud) |

---

## 🏗️ Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                      VPC — 10.0.0.0/16                        │
│                     (65,536 IP addresses)                     │
│                                                                │
│   ┌────────────────────────┐    ┌─────────────────────────┐  │
│   │   Public Subnet         │    │   Private Subnet         │  │
│   │   10.0.1.0/24 (256 IPs) │    │   10.0.2.0/24 (256 IPs)  │  │
│   │                          │    │                           │  │
│   │   ┌──────────────────┐  │    │   ┌───────────────────┐  │  │
│   │   │  EC2 / VM         │  │    │   │  Database /       │  │  │
│   │   │  Web Server        │  │    │   │  Internal Service │  │  │
│   │   └────────┬─────────┘  │    │   └───────────────────┘  │  │
│   │            │             │    │                           │  │
│   └────────────┼────────────┘    └─────────────────────────┘  │
│                │                                                │
│         Route Table (0.0.0.0/0 → IGW)                          │
│                │                                                │
│         ┌──────┴───────┐                                       │
│         │ Internet      │                                       │
│         │ Gateway       │                                       │
│         └───────────────┘                                       │
│                                                                │
│   Security Group: TCP 22 (SSH) · TCP 80 (HTTP)                 │
└──────────────────────────────────────────────────────────────┘
```

---

## 📦 Prerequisites

- Docker installed and running (for LocalStack)
- AWS CLI (`awslocal` wrapper for LocalStack)
- An OpenScaler account ([platform.alpha.openscaler.net](https://platform.alpha.openscaler.net))
- `curl` for direct REST API calls to OpenScaler
- Basic familiarity with Bash

---

## 🧪 Part 1 — LocalStack Implementation

### 1. Start LocalStack

```bash
docker run -d \
  --name localstack \
  -p 4566:4566 \
  -p 4510-4559:4510-4559 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  localstack/localstack:latest
```

Verify it's running:

```bash
docker ps
```

### 2. Create the VPC

```bash
awslocal ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=zaki-vpc}]'
```

> 📌 Save the returned `VpcId`.

### 3. Create Public & Private Subnets

```bash
# Public Subnet
awslocal ec2 create-subnet \
  --vpc-id <VPC_ID> \
  --cidr-block 10.0.1.0/24 \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=public-subnet}]'

# Private Subnet
awslocal ec2 create-subnet \
  --vpc-id <VPC_ID> \
  --cidr-block 10.0.2.0/24 \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=private-subnet}]'
```

### 4. Create & Attach an Internet Gateway

```bash
awslocal ec2 create-internet-gateway \
  --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=zaki-igw}]'

awslocal ec2 attach-internet-gateway \
  --vpc-id <VPC_ID> \
  --internet-gateway-id <IGW_ID>
```

### 5. Create a Route Table (public route to the internet)

```bash
awslocal ec2 create-route-table \
  --vpc-id <VPC_ID> \
  --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=public-rt}]'

awslocal ec2 create-route \
  --route-table-id <ROUTE_TABLE_ID> \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id <IGW_ID>

awslocal ec2 associate-route-table \
  --route-table-id <ROUTE_TABLE_ID> \
  --subnet-id <PUBLIC_SUBNET_ID>
```

### 6. Create a Security Group (Least Privilege)

```bash
awslocal ec2 create-security-group \
  --group-name zaki-sg \
  --description "Allow SSH and HTTP" \
  --vpc-id <VPC_ID>

awslocal ec2 authorize-security-group-ingress \
  --group-id <SG_ID> --protocol tcp --port 22 --cidr 0.0.0.0/0

awslocal ec2 authorize-security-group-ingress \
  --group-id <SG_ID> --protocol tcp --port 80 --cidr 0.0.0.0/0
```

### 7. Launch the EC2 Instance

```bash
awslocal ec2 run-instances \
  --image-id ami-12345678 \
  --instance-type t2.micro \
  --subnet-id <PUBLIC_SUBNET_ID> \
  --security-group-ids <SG_ID> \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=zaki-server}]'
```

---



---

## ✅ Verification

**LocalStack:**

```bash
awslocal ec2 describe-vpcs
awslocal ec2 describe-subnets
awslocal ec2 describe-internet-gateways
awslocal ec2 describe-route-tables
awslocal ec2 describe-security-groups
awslocal ec2 describe-instances


---

## 📝 Resource Reference

Keep a local (git-ignored) `.env` or `ids.txt` file with your resource IDs:

```env
# LocalStack
VPC_ID=vpc-xxxxxxxx
PUBLIC_SUBNET_ID=subnet-xxxxxxxx
PRIVATE_SUBNET_ID=subnet-xxxxxxxx
IGW_ID=igw-xxxxxxxx
ROUTE_TABLE_ID=rtb-xxxxxxxx
SECURITY_GROUP_ID=sg-xxxxxxxx

# OpenScaler
OS_PROJECT_ID=dz
OS_VPC_ID=156
OS_REGION=alg1
```

> 🔒 **Never commit tokens, passwords, or `.pem` keys to GitHub.** Add them to `.gitignore`.

---

## 🧹 Cleanup

**LocalStack:**

```bash
awslocal ec2 terminate-instances --instance-ids <INSTANCE_ID>
awslocal ec2 detach-internet-gateway --internet-gateway-id <IGW_ID> --vpc-id <VPC_ID>
awslocal ec2 delete-internet-gateway --internet-gateway-id <IGW_ID>
awslocal ec2 delete-subnet --subnet-id <PUBLIC_SUBNET_ID>
awslocal ec2 delete-subnet --subnet-id <PRIVATE_SUBNET_ID>
awslocal ec2 delete-security-group --group-id <SG_ID>
awslocal ec2 delete-vpc --vpc-id <VPC_ID>
```



---

## 🎓 Key Concepts Learned

| Concept | Description |
|---|---|
| **CIDR** | Classless Inter-Domain Routing — defining IP ranges and subnet sizes |
| **VPC** | Isolated virtual network within a cloud provider |
| **Public vs Private Subnet** | Internet-facing vs internally isolated resources |
| **Internet Gateway** | The single door connecting a VPC to the public internet |
| **Route Table** | Rules that determine where network traffic is directed |
| **Security Group** | Stateful virtual firewall at the instance level |
| **Least Privilege** | Only opening the ports strictly necessary |
| **Bearer Token Auth** | OAuth-style short-lived tokens for OpenScaler's REST API |

---

## 🌐 Real-World Use Cases

This exact pattern powers production infrastructure at scale:

- **3-Tier Web Applications** — web tier public, app & database tiers private
- **Bastion Host / Jump Box** — one public instance for secure SSH access to private resources
- **Load Balancer + Auto Scaling** — public-facing LB, backend instances in public/private subnets
- **Microservices (Docker/Kubernetes)** — private worker nodes, public ingress
- **CI/CD Pipelines** — public build servers deploying to private production environments

---

## 🚀 Roadmap & Next Steps

| Stage | Topic | Status |
|---|---|---|
| ✅ | VPC + Subnets + Routing + Security Groups + EC2 | Done |
| ⬜ | S3 / Object Storage | Next |
| ⬜ | Terraform (Infrastructure as Code) | Planned |
| ⬜ | Docker & Docker Compose | Planned |
| ⬜ | CI/CD (GitHub Actions / Jenkins) | Planned |
| ⬜ | Kubernetes + Monitoring (Prometheus/Grafana) | Planned |

**Rule:** never skip a stage — each one builds on the previous.

---

## 👤 Author

**Zaki (BEN MAIDI Zakaria Djamal Eddine)**
Aspiring DevOps Engineer — building cloud infrastructure one command at a time.

---

## 📄 License

This project is for educational purposes only.
