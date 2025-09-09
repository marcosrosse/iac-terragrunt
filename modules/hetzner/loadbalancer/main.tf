resource "hcloud_load_balancer" "k3s" {
  name               = var.name
  load_balancer_type = "lb11"
  location           = var.location
  labels            = var.labels
}

resource "hcloud_load_balancer_network" "k3s" {
  load_balancer_id = hcloud_load_balancer.k3s.id
  network_id       = var.network_id
  ip              = var.loadbalancer_ip
}

resource "hcloud_load_balancer_service" "k3s" {
  load_balancer_id = hcloud_load_balancer.k3s.id
  protocol         = var.protocol
  listen_port      = var.listen_port
  destination_port = var.target_port

  health_check {
    protocol = var.protocol
    port     = var.target_port
    interval = 10
    timeout  = 5
    retries  = 3
  }
}

resource "hcloud_load_balancer_target" "k3s" {
  count            = length(var.server_ids)
  type             = "server"
  load_balancer_id = hcloud_load_balancer.k3s.id
  server_id        = var.server_ids[count.index]
  use_private_ip   = true

  depends_on = [
    hcloud_load_balancer_network.k3s
  ]
}
