include {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../00-network"
}

dependency "firewall" {
  config_path = "../01-firewall"
}

dependency "ssh_key" {
  config_path = "../02-ssh-key"
}

dependencies {
  paths = [
    "../00-network",
    "../01-firewall",
    "../02-ssh-key"
  ]
}

terraform {
  source = "../../../../../modules/hetzner/instances"
}

inputs = {
  # Instance counts
  control_plane_count = 1
  worker_count       = 1

  # Instance types
  control_plane_type = "cax11"
  worker_type       = "cax11"

  # Common configurations
  instance_prefix         = "k3s"
  image                  = "ubuntu-22.04"
  location              = "fsn1"  # Falkenstein, Germany
  user_data_template_path = "${get_repo_root()}/tools/cloud-init/cloud-init.yaml"
  network_name          = dependency.network.outputs.network_name
  ssh_key_name         = dependency.ssh_key.outputs.ssh_key_name

  labels = {
    Name        = "k3s"
    Environment = "prod"
    ManagedBy   = "terragrunt"
  }

  # Firewall
  firewall_name = dependency.firewall.outputs.firewall_name

  # Inventory file path
  inventory_file_path = "${get_terragrunt_dir()}/inventory.yaml"
}
