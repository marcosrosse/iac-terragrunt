output "firewall_id" {
  description = "ID do firewall criado"
  value       = hcloud_firewall.k3s_firewall.id
}

output "firewall_name" {
  description = "Nome do firewall"
  value       = hcloud_firewall.k3s_firewall.name
}
