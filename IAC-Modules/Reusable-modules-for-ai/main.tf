# Define a reusable module for an AI Workstation
module "ai_workstation" {
  source = "./modules/compute"
  instance_count = var.node_count
  ami_id         = data.aws_ami.ubuntu_gpu.id
  instance_type  = "g4dn.xlarge" # GPU instance
}

# Security Group for high-performance networking (RDMA/RoCE)
resource "aws_security_group" "ai_internal" {
  name        = "ai-internal-traffic"
  description = "Allow inter-node communication for distributed training"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }
}
