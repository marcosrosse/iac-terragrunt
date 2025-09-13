output "network_id" {
  description = "Network ID"
  value       = hcloud_network.private_net.id
}

output "network_name" {
  description = "Network name"
  value       = hcloud_network.private_net.name
}

output "network_ip_range" {
  description = "Network IP range"
  value       = hcloud_network.private_net.ip_range
}

output "subnet_id" {
  description = "Network Subnet ID"
  value       = hcloud_network_subnet.generic_subnet.id
}
