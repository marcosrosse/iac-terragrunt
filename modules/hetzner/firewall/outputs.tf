output "firewall_id" {
  description = "Firewall ID"
  value       = hcloud_firewall.generic_firewall.id
}

output "firewall_name" {
  description = "Firewell name"
  value       = hcloud_firewall.generic_firewall.name
}
