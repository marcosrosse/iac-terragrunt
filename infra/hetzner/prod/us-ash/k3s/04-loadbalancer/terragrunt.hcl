include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "network" {
  config_path = "../00-network"
}

dependency "instances" {
  config_path = "../03-instances"
}

terraform {
  source = "../../../../../../modules/hetzner/loadbalancer"
}

dependencies {
  paths = [
    "../00-network",
    "../03-instances"
  ]
}

locals {
  labels = merge(
    include.root.inputs.labels,
    {
      type            = "lb"
    }
  )
}

inputs = {
  name                = "${include.root.inputs.service_name}-lb"
  location            = include.root.inputs.region

  network_id          = dependency.network.outputs.network_id
  loadbalancer_ip     = include.root.inputs.loadbalancer_ip
  server_ids          = dependency.instances.outputs.control_plane_server_ids


  protocol            = "tcp"
  listen_port         = 6443
  target_port         = 6443

  labels              = local.labels
}
