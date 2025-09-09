output "network_id" {
  description = "ID da rede criada"
  value       = hcloud_network.private_net.id
}

output "network_name" {
  description = "Nome da rede"
  value       = hcloud_network.private_net.name
}

output "network_ip_range" {
  description = "Range de IP da rede"
  value       = hcloud_network.private_net.ip_range
}

output "subnet_id" {
  description = "ID da subnet criada"
  value       = hcloud_network_subnet.k3s_subnet.id
}
