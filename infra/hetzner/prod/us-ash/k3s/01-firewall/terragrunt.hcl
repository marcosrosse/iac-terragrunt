include {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../00-network"
}

terraform {
  source = "../../../../../modules/hetzner/firewall"
}

dependencies {
  paths = ["../00-network"]
}

inputs = {
  firewall_name = "k3s-firewall"
  labels = {
    Name        = "k3s-firewall"
    Environment = "prod"
    ManagedBy   = "terragrunt"
  }

  firewall_rules = [
    {
      direction   = "in"
      protocol    = "tcp"
      port        = "22"
      source_ips  = ["0.0.0.0/0"]  # Restrict to my IP
      description = "SSH access"
    },
    {
      direction   = "in"
      protocol    = "tcp"
      port        = "80"
      source_ips  = ["10.0.0.0/16"] # Restrict access only to the internal network.
      description = "HTTP access"
    },
    {
      direction   = "in"
      protocol    = "tcp"
      port        = "443"
      source_ips  = ["10.0.0.0/16"] # Restrict access only to the internal network.
      description = "HTTPS access"
    },
    {
      direction   = "in"
      protocol    = "tcp"
      port        = "6443"
      source_ips  = ["10.100.0.0/24"] # Restrict to my IP
      description = "Kubernetes API Server"
    },
    {
      direction   = "in"
      protocol    = "udp"
      port        = "8472"
      source_ips  = ["10.0.0.0/16"]
      description = "VXLAN (Kubernetes)"
    }
  ]
}
