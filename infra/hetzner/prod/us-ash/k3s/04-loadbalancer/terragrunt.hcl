include {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../00-network"
}

dependency "instances" {
  config_path = "../03-instances"
}

terraform {
  source = "../../../../../modules/hetzner/loadbalancer"
}

dependencies {
  paths = [
    "../00-network",
    "../03-instances"
  ]
}

inputs = {
  name = "k3s-loadbalancer"
  location = "fsn1"

  network_id = dependency.network.outputs.network_id
  loadbalancer_ip = "10.0.1.100"
  server_ids = dependency.instances.outputs.control_plane_server_ids


  protocol = "http"
  listen_port = 80
  target_port = 80

  labels = {
    Name = "k3s-loadbalancer"
    Environment = "prod"
    ManagedBy = "terragrunt"
  }
}
