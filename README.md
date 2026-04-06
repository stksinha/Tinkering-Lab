# 🧪 Tinkering-Lab

A centralized sandbox for experimenting with Cloud Architecture, DevOps patterns, and AI integration. This repository serves as a living document of my technical journey across multiple ecosystems.

---

## 🛠 Tech Radar

### ☁️ Cloud Platforms
* **AWS:** Managed Streaming for Kafka (MSK), IAM, S3, EC2.
* **Azure:** Entra ID, Azure Kubernetes Service (AKS).
* **GCP:** Google Kubernetes Engine (GKE), Cloud Run.

### ☸️ Containers & Orchestration
* **Docker:** Containerization of microservices and custom environments.
* **Kubernetes:** Helm charts, ingress controllers, and cluster management.

### 📜 Infrastructure as Code (IaC) & Config
* **Terraform:** Provisioning multi-cloud resources (AWS/Azure/GCP).
* **Ansible:** Configuration management and automated OS hardening.
* **Shell (BASH):** Automation scripts for MSK operations and local CLI workflows.

### 🤖 Artificial Intelligence
* **LLM Integration:** Prompt engineering and API experimentation.
* **Automation:** Using AI to optimize CI/CD pipelines and script generation.

### 🚀 CI/CD
* **Jenkins / GitHub Actions:** Automated testing and deployment pipelines.

---

## 📂 Laboratory Roadmap

| Directory | Experiment | Technology |
| :--- | :--- | :--- |
| `/aws-msk` | MSK Cluster automation & Shell-based Producers | AWS, Shell, Kafka |
| `/iac-modules` | Cross-cloud provisioning templates | Terraform, Ansible |
| `/k8s-manifests` | Deployment strategies (Blue/Green, Canary) | K8s, Docker |
| `/ai-lab` | AI-driven script generation & API tests | Python, OpenAI/Claude |
| `/pipelines` | Jenkinsfiles and GitHub Action workflows | CI/CD |

---

## 🔧 Highlights: MSK & Shell Automation

One of the core focuses of this lab is mastering **Amazon MSK**. I use Shell scripts to bridge the gap between infrastructure and data operations:
* **Dynamic Broker Discovery:** Scripts to fetch bootstrap strings via AWS CLI.
* **Topic Management:** Automated creation and partition rebalancing.
* **Security:** Implementing IAM Access Control for Kafka clients.

---

## 📝 How to Use This Repo
1. **Explore:** Navigate to a specific technology directory.
2. **Read:** Each folder contains a local `README.md` with setup instructions.
3. **Safety First:** Ensure you have your own provider credentials set up locally. *Never commit `.tfstate` or `.env` files.*

---
*“Always be tinkering.”* 🚀
