include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../modules/hetzner/network"
}

inputs = {
  network_name     = "k3s-network"
  network_ip_range = "10.0.0.0/16"
  labels = {
    Name        = "k3s-network"
    Environment = "prod"
    ManagedBy   = "terragrunt"
  }
}
