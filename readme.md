# Lima + Terraform Kubernetes Node Setup

This repository automates the creation of Kubernetes nodes on macOS using Lima and Terraform.

## Features
- Automates Lima VM creation with Terraform
- Supports Kubernetes clusters (Master + Workers)
- Runs on macOS without needing Docker or Colima
- Prepares VMs for kubeadm setup

## Setup Instructions

### Install Dependencies
Ensure you have Terraform and Lima installed:
```sh
brew install terraform lima
```

### Clone the Repository & Initialize Terraform
```sh
git clone https://github.com/ixidod/lima-k8s.git
cd lima-k8s
terraform init
```

### Deploy the Nodes
```sh
terraform apply -auto-approve
```

### Verify the Nodes
```sh
limactl list
```

### Access a Node
```sh
limactl shell k8s-master
```

### Destroy Everything
If you want to remove all nodes:
```sh
terraform destroy -auto-approve
```

## Repository Structure
```
lima-k8s/
├── lima-nodes-setup.yaml   # Ansible playbook for node setup
├── lima-nodes-ssh.yaml     # Ansible playbook for SSH setup and updates
├── main.tf                 # Terraform configuration for Lima VMs
├── terraform.tfstate.backup # Terraform backup state
└── README.md               # Project documentation
```

## Future Improvements
- Automate Kubernetes installation with kubeadm
- Ansible playbook for post-setup
- Helm and GitOps integration


