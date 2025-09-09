output "control_plane_ips" {
  description = "Public IPs of control plane nodes"
  value       = [for node in hcloud_server.k3s_control_plane : node.ipv4_address]
}

output "worker_ips" {
  description = "Public IPs of worker nodes"
  value       = [for node in hcloud_server.k3s_worker : node.ipv4_address]
}

output "control_plane_private_ips" {
  description = "Private IPs of control plane nodes"
  value       = [for node in hcloud_server.k3s_control_plane : tolist(node.network)[0].ip]
}

output "worker_private_ips" {
  description = "Private IPs of worker nodes"
  value       = [for node in hcloud_server.k3s_worker : tolist(node.network)[0].ip]
}

output "inventory_path" {
  description = "Path to Ansible inventory file"
  value       = local_file.ansible_inventory.filename
}

output "control_plane_server_ids" {
  description = "Control plane server IDs"
  value       = [for node in hcloud_server.k3s_control_plane : node.id]
}
