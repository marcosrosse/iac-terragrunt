# terragrunt.hcl (network)
include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../../../../modules/hetzner/network"
}

locals {
  network_name     = "${include.root.inputs.service_name}-network"
  network_ip_range = include.root.inputs.network_ip_range
  subnet_ip_range  = include.root.inputs.subnet_ip_range
  
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