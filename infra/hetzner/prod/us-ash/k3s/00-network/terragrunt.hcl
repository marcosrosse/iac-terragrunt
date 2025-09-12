# terragrunt.hcl (network)
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../../../../modules/hetzner/network"
}

locals {
  network_name     = "k3s-network"
  network_ip_range = "10.0.0.0/16"
  subnet_ip_range  = "10.0.0.0/24"
  
  network_zone     = include.root.inputs.zone
  
  labels = merge(
    include.root.inputs.labels,
    {
      name = local.network_name
      type = "network"
    }
  )
}

inputs = {
  network_name    = local.network_name
  ip_range        = local.network_ip_range
  network_zone    = local.network_zone
  subnet_ip_range = local.subnet_ip_range
  labels          = local.labels
}