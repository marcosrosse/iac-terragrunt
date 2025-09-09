data "hcloud_ssh_key" "k3s_key" {
  name = var.ssh_key_name
}

data "hcloud_network" "k3s_network" {
  name = var.network_name
}

data "hcloud_firewall" "k3s_firewall" {
  name = var.firewall_name
}

resource "hcloud_server" "k3s_control_plane" {
  count       = var.control_plane_count
  name        = "${var.instance_prefix}-control-${count.index + 1}"
  server_type = var.control_plane_type
  image       = var.image
  location    = var.location

  ssh_keys = [data.hcloud_ssh_key.k3s_key.id]
  labels  = merge(var.labels, {
    Role = "control-plane"
  })

  network {
    network_id = data.hcloud_network.k3s_network.id
  }

  user_data = templatefile(var.user_data_template_path, {
    hostname = "${var.instance_prefix}-control-${count.index + 1}"
  })

  firewall_ids = [data.hcloud_firewall.k3s_firewall.id]
}

resource "hcloud_server" "k3s_worker" {
  count       = var.worker_count
  name        = "${var.instance_prefix}-worker-${count.index + 1}"
  server_type = var.worker_type
  image       = var.image
  location    = var.location

  ssh_keys = [data.hcloud_ssh_key.k3s_key.id]
  labels  = merge(var.labels, {
    Role = "worker"
  })

  network {
    network_id = data.hcloud_network.k3s_network.id
  }

  user_data = templatefile(var.user_data_template_path, {
    hostname = "${var.instance_prefix}-worker-${count.index + 1}"
  })

  firewall_ids = [data.hcloud_firewall.k3s_firewall.id]
}

resource "local_file" "ansible_inventory" {
  filename = var.inventory_file_path
  content  = templatefile("${path.module}/inventory.tmpl", {
    control_nodes = hcloud_server.k3s_control_plane[*]
    worker_nodes  = hcloud_server.k3s_worker[*]
  })
}
