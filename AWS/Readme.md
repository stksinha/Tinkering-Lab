# ☁️ AWS Engineering Lab

This directory is a comprehensive knowledge base of AWS services and configurations. Each file within this folder is a **dual-method guide**, providing step-by-step instructions for both the **AWS Management Console** and the **AWS CLI**.

---

## 🎯 Methodology
Every lab in this folder follows a consistent format:
* **Console Path:** Visual walkthroughs for architectural understanding.
* **CLI Path:** Command-line snippets for automation and speed.
* **Verification:** Steps to confirm the resource is configured correctly.

---

## 🗺️ Learning Roadmap
The following tasks are documented in this folder, categorized by complexity levels:

### 🟢 Level 1: Foundations
*Foundational resource management and IAM security.*
* **EC2:** Keypairs, Security Groups, GP3 Volumes, Instance Lifecycle, AMIs, and Snapshots.
* **IAM:** Users, Groups, Roles, and Read-Only Console Access Policies.
* **S3:** Public/Private buckets, Versioning, and Data Transfer/Sync.
* **VPC:** Subnets, Elastic IPs, CIDR definition, and IPv6 implementation.
* **RDS:** Public instances, Snapshots, Delete Protection, and Engine upgrades.

### 🟡 Level 2: Networking & Intermediate Config
*Secure connectivity and instance optimization.*
* **Connectivity:** VPC Peering, NAT Gateways, and Elastic IP hosting.
* **Servers:** Nginx Web Server setup and CloudWatch Alarms.
* **Architecture:** Public vs. Private VPCs and Secure SSH hardening.
* **Containers/Serverless:** Private ECR Repositories and Lambda Function creation.

### 🟠 Level 3: Orchestration & IaC
*Managing infrastructure as code and container clusters.*
* **Containers:** Amazon ECS and EKS (Kubernetes) scaling.
* **IaC:** AWS CloudFormation templates.
* **Security:** AWS KMS Data Encryption and S3 Role-based permissions.
* **Scaling:** Application Load Balancer (ALB) and Static Website hosting.

### 🔴 Level 4: Automation & Distributed Systems
*CI/CD, High Availability, and Event-Driven logic.*
* **DevOps:** CI/CD Automation via AWS CodePipeline.
* **Resiliency:** Auto Scaling Groups (ASG) for High Availability.
* **Messaging:** Decoupling with SQS and SNS.
* **Serverless Ops:** Event-Driven processing (S3 ➔ Lambda) and API Gateway.

---

## 📂 Documentation Index
Since all lab files are located in this root directory, please refer to the specific `.md` or `.txt` files for each task.

> [!TIP]
> Use `Ctrl+F` (or `Cmd+F`) on this page to quickly find the specific service or task you are looking for.

---
**Security Note:** All labs follow the principle of least privilege. Remember to clean up resources after testing to avoid unnecessary AWS costs.
