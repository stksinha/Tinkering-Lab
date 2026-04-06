# 🧪 Tinkering-Lab

A professional sandbox for exploring the intersection of Cloud Engineering, DevOps, and AI. This repository documents my hands-on experience with modern infrastructure patterns, automated messaging systems, and multi-cloud environments.

---

## 🏗 Repository Architecture

I maintain a modular structure to demonstrate separation of concerns across different layers of the stack:

### ☁️ Cloud Platforms & IaC
* **`/aws`**: Infrastructure as Code (Terraform/Ansible) for VPCs, IAM roles, and compute.
* **`/azure` & `/gcp`**: Cross-cloud experimentation and identity management (Entra ID/GKE).
* **`/iac-modules`**: Reusable Terraform modules and Ansible playbooks for system hardening.

### 🎡 Streaming & Data
* **`/msk`**: Specialized configurations for Amazon Managed Streaming for Apache Kafka.
    * Focus on: Cluster provisioning, IAM Access Control, and storage optimization.

### 🐚 Automation & Logic
* **`/shell`**: Production-ready Bash scripts for "glue" automation.
    * Features: Dynamic MSK broker discovery, automated health checks, and CLI wrappers.

### 🤖 Emerging Tech
* **`/ai`**: Experiments with LLM APIs and AI-assisted DevOps workflows.
* **`/containers`**: Dockerfiles and Kubernetes manifests for microservices.

---

## 🛠 Tech Stack

| Category | Tools |
| :--- | :--- |
| **Cloud** | AWS, Azure, GCP |
| **Containers** | Docker, Kubernetes (EKS/AKS/GKE) |
| **IaC** | Terraform, Ansible |
| **Messaging** | AWS MSK (Kafka) |
| **Scripting** | Bash (Shell), Python |
| **CI/CD** | GitHub Actions, Jenkins |

---

## 🌟 Featured Experiment: MSK Automation
One of the core focuses of this lab is automating **Amazon MSK** workflows. My `/shell` directory contains custom logic to:
1. Fetch bootstrap brokers dynamically via AWS CLI.
2. Automate topic creation and ACL management.
3. Validate connectivity from EC2 client machines using secure IAM wrappers.

---

## 🚦 Getting Started
1. **Prerequisites**: Ensure you have the [AWS CLI](https://aws.amazon.com/cli/) and [Terraform](https://www.terraform.io/) installed.
2. **Environment**: Never hardcode secrets. Use `export` for environment variables or AWS Secrets Manager.
3. **Usage**: Navigate to any subdirectory and refer to the local `README.md` for specific execution steps.

---
**Disclaimer:** This is a lab environment. All infrastructure is designed for experimentation and may require modification for production-grade security and scale.
