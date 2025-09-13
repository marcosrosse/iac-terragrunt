include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
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
  source = "../../../../../../modules/hetzner/instances"
}

locals {
  labels = merge(
    include.root.inputs.labels,
    {
      type = "instance"
    }
  )
}

inputs = {
  control_plane_count       = 1
  worker_count              = 0

  control_plane_type        = "ccx13"
  worker_type               = "ccx23"

  image                     = "ubuntu-22.04"
  location                  = include.root.inputs.region
  instance_prefix           = include.root.inputs.service_name
  ssh_key_name              = "${include.root.inputs.service_name}-key"
  network_name              = "${include.root.inputs.service_name}-network"
  user_data_template_path   = "${get_repo_root()}/tools/cloud-init/cloud-init.yaml"

  labels                    = local.labels

  firewall_name             = "${include.root.inputs.service_name}-firewall"

  inventory_file_path       = "${get_terragrunt_dir()}/inventory.yaml"
}
