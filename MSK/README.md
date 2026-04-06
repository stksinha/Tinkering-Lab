# 🎡 AWS MSK (Managed Streaming for Apache Kafka) Lab

This directory focuses on the administration, configuration, and automation of **Amazon MSK**. It serves as a repository for production-ready Shell scripts and architectural documentation for streaming data workloads.

---

## 🚀 Current Automation Scripts
These scripts are designed to be executed from an EC2 Client machine or a local environment with appropriate IAM permissions.

| Script Name | Functionality | Key Kafka Parameters |
| :--- | :--- | :--- |
| **`create-topic.sh`** | Automates topic creation with custom partition/replication factors. | `--partitions`, `--replication-factor` |
| **`set-retention.sh`** | Dynamically updates topic-level data retention policies. | `retention.ms`, `retention.bytes` |
| **`delete-records.sh`** | Safely purges records from a topic up to a specific offset. | `delete-records.json` |

---

## 📖 Operational Workflows

### 1. Topic Management
* **Creation:** Standardized scripts to ensure topics are created with high availability (3x replication) and balanced partitions.
* **Cleanup:** Using the `delete-records` functionality to manage disk space without deleting the entire topic metadata.

### 2. Policy Tuning (Retention)
* Detailed scripts for adjusting `retention.ms` to handle different use cases (e.g., short-lived real-time streams vs. 7-day historical buffers).

---

## 🗺️ Upcoming Documentation (Roadmap)
I am currently developing deep-dive guides for the following advanced MSK scenarios:

* **[ ] MSK Cluster Creation:** Step-by-step automation via AWS CLI and Terraform.
* **[ ] On-Prem to MSK Connectivity:** Configuring Site-to-Site VPN or Direct Connect for hybrid Kafka clusters.
* **[ ] IAM Access Control:** Implementing SASL/IAM for passwordless authentication.
* **[ ] Monitoring:** Setting up CloudWatch alarms for `CpuUser` and `BytesInPerSec`.

---

## 🛠 Prerequisites
To run the scripts in this folder, ensure your environment has:
1.  **Java 8+** installed.
2.  **Apache Kafka Client** binaries downloaded and added to your `$PATH`.
3.  **IAM Policy:** Permissions for `kafka:DescribeCluster` and `kafka:GetBootstrapBrokers`.

---

## ⚡ Quick Start: Fetching Brokers
Before running the scripts, export your bootstrap servers:
```bash
export MSK_BROKERS=$(aws kafka get-bootstrap-brokers --cluster-arn <YOUR_CLUSTER_ARN> --query 'BootstrapBrokerString' --output text)
