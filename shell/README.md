# 🐚 Shell & Automation Lab

This directory is a collection of production-grade scripts and automation playbooks designed to manage infrastructure at scale. I focus on bridging the gap between manual CLI tasks and fully orchestrated DevOps workflows.

---

## 🚀 Current Automation Scripts

### 🛡️ Security & Compliance
* **`docker-qualys-scan.sh`**
    * **Function:** Orchestrates automated vulnerability scanning for Docker images using the **Qualys Cloud Agent**.
    * **Workflow:** Triggers image scan ➔ Extracts JSON/PDF reports ➔ Parses critical vulnerabilities.
    * **Notification:** Integrated with `mailx` to dispatch results to security stakeholders.

### ⚙️ Middleware & App Server
* **`jboss-config-helper.sh`**
    * **Function:** Automates JBoss/WildFly application server tuning (Datasources, JVM Heap, System Properties).

---

## 🛠️ Upcoming & In-Development

## 🏗️ In-Development: The "Docker Factory" & ECR Pipeline

I am building an interactive automation suite to standardize how images are built and stored in **Amazon ECR**.

### 🐳 Automated Image Builder (`build-and-push.sh`)
* **Logic:** Takes user inputs (Base Image, App Version, Maintainer) and dynamically generates a `Dockerfile`.
* **Multi-Repo Routing:** Automatically authenticates and pushes images to their respective ECR Repositories:
    * `rhel-base` | `jboss` | `rhttpd` | `apache` | `tomcat`
* **Tagging Strategy:** Implements standardized tagging (e.g., `v1.0.2-stable`, `latest`, `hotfix-2026-04-06`) to ensure version traceability.
  
### 📊 Multi-Server Health Dashboard (Ansible + Shell)
* **Status:** *In Development*
* **Goal:** An Ansible-driven engine to perform fleet-wide health checks across **JBoss, Tomcat, and HTTP** servers.
* **Metrics:** CPU Load, Memory Utilization, and Disk Space.
* **Output:** Collects data from all nodes, compiles a centralized **CSV Report**, and sends it as an email attachment for daily infrastructure auditing.

---

## 📜 Scripting Standards
To ensure reliability across RHEL, Ubuntu, and Amazon Linux, these scripts utilize:
1. **Defensive Coding:** `set -euo pipefail` to catch errors early.
2. **Modular Design:** Separation of logic and configuration via `.env` files.
3. **Dynamic Auth:** Uses `aws ecr get-login-password` to refresh registry tokens automatically.
4. **Auditability:** Every build and push event is logged with a timestamp for troubleshooting.

---

## 📂 How to Use
1. **Permissions:** `chmod +x <script_name>.sh`
2. **Environment:** Ensure the `ANSIBLE_INVENTORY` path is set for health-check playbooks.
3. **Credentials:** Use SSH keys or Ansible Vault; **never** hardcode passwords in scripts.

---
> [!TIP]
> The Health Check automation is designed to be triggered via **Cron** or **Jenkins**, providing a low-overhead monitoring solution for environments without Prometheus/Grafana.
