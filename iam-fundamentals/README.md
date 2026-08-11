# IAM Fundamentals — AWS Identity and Access Management

## Overview
A hands-on project demonstrating core AWS Identity and Access Management (IAM) concepts, implemented and tested locally using LocalStack. The project covers identity management, custom policy authoring, and secure service-to-service access patterns following the principle of least privilege.

## Objectives
- Understand and implement IAM Users, Groups, Policies, and Roles
- Author custom IAM policies in JSON following least-privilege principles
- Configure secure, credential-free access for AWS services via IAM Roles
- Practice infrastructure management using the AWS CLI

## Tools & Technologies
- **LocalStack** — Local AWS cloud stack emulator
- **AWS CLI / awslocal** — Command-line interface for AWS resource management
- **Docker** — Container runtime for LocalStack
- **JSON** — Policy document authoring

## Implementation

### 1. Identity Management (Users & Groups)
Created an IAM group to manage permissions at scale, and a user assigned to that group, avoiding per-user policy duplication.

```bash
awslocal iam create-group --group-name devops
awslocal iam create-user --user-name zaki-ops
awslocal iam add-user-to-group --user-name zaki-ops --group-name devops
```

### 2. Custom Least-Privilege Policy
Authored a custom IAM policy (`policy.json`) granting read-only access (`s3:GetObject`) to a single, explicitly scoped S3 bucket — no write, delete, or cross-resource permissions.

```bash
awslocal iam put-group-policy \
  --group-name devops \
  --policy-name policy \
  --policy-document file://policy.json
```

### 3. IAM Role for Secure Service Access
Created an IAM Role (`ec2--s3--services`) with a Trust Policy (`role.json`) scoped exclusively to the EC2 service, enabling temporary, credential-free access instead of hardcoded static keys.

```bash
awslocal iam create-role \
  --role-name ec2--s3--services \
  --assume-role-policy-document file://role.json

awslocal iam put-role-policy \
  --role-name ec2--s3--services \
  --policy-name policy \
  --policy-document file://policy.json
```

## Key Concepts Demonstrated
| Concept | Description |
|---|---|
| Least Privilege | Access scoped to only what is functionally required |
| IAM User vs Role | Static identity (long-lived credentials) vs. temporary, service-assumed identity |
| Trust Policy | Explicit control over which principal may assume a Role |
| Policy-as-Code | Manually authored JSON policies instead of console defaults |

## Notes & Limitations
This project was implemented using LocalStack Community Edition to simulate AWS locally. While policy authoring and resource creation are fully functional, strict IAM permission enforcement is limited in the free tier. The objective here was to master correct syntax, structure, and security patterns — full enforcement testing will be validated against a live AWS account in a later stage.
