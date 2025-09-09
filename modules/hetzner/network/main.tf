resource "hcloud_network" "private_net" {
  name     = var.network_name
  ip_range = var.network_ip_range
  labels   = var.labels
}

resource "hcloud_network_subnet" "k3s_subnet" {
  type         = "cloud"
  network_id   = hcloud_network.private_net.id
  network_zone = var.network_zone
  ip_range     = var.subnet_ip_range
}