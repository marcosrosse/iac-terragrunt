output "ssh_key_id" {
  description = "SSH Key ID"
  value       = hcloud_ssh_key.generic.id
}

output "ssh_key_name" {
  description = "SSH Key name"
  value       = hcloud_ssh_key.generic.name
}

output "ssh_key_fingerprint" {
  description = "Fingerprint of the SSH Key"
  value       = hcloud_ssh_key.generic.fingerprint
}
