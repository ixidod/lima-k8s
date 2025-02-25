terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
  }
}

variable "lima_nodes" {
  default = ["k8s-master", "k8s-worker1", "k8s-worker2", "k8s-worker3"]
}

resource "null_resource" "lima_instances" {
  for_each = toset(var.lima_nodes)

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ~/.lima

      # Check if the instance already exists, if so, delete it properly
      if limactl list | grep -q ${each.key}; then
        echo "Force-stopping existing Lima VM: ${each.key}..."
        limactl stop -f ${each.key} && limactl delete -f ${each.key}
      fi

      echo "Creating Lima VM ${each.key}..."

      cat <<EOF > ~/.lima/${each.key}.yaml
vmType: "vz"
cpus: 4
memory: "4GiB"
disk: "10GiB"
images:
  - location: "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-arm64.img"
    arch: "aarch64"
EOF

      limactl start ~/.lima/${each.key}.yaml --tty=false
    EOT
  }
}

output "lima_nodes" {
  value = "Lima Kubernetes Nodes Created: ${join(", ", var.lima_nodes)}"
}

