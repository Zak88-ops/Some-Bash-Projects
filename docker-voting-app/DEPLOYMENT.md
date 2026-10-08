# Voting App on OpenScaler

Multi-container app (Python, Node.js, .NET, Redis, PostgreSQL) deployed with Docker Compose on an Ubuntu 24.04 cloud server in Algiers.

Based on Docker's open-source sample: https://github.com/dockersamples/example-voting-app

## Architecture
vote (Python) -> Redis -> worker (.NET) -> PostgreSQL -> result (Node.js)

## Deploy
1. Create an Ubuntu 24.04 server (2 vCPU, 4 GiB RAM) with an SSH key.
2. Install Docker: `apt update && apt install -y docker.io docker-compose-v2 git`
3. Copy the project: `scp -P 9240 -r docker-voting-app root@ssh.alpha.openscaler.net:/root/`
4. Start it: `docker compose up -d --build`
5. Add port-forwarding rules for the vote (5000) and result (5001) ports.

## Check
`docker compose ps` shows all 5 services running.
