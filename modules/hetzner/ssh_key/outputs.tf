output "ssh_key_id" {
  description = "ID da chave SSH criada"
  value       = hcloud_ssh_key.k3s.id
}

output "ssh_key_name" {
  description = "Nome da chave SSH"
  value       = hcloud_ssh_key.k3s.name
}

output "ssh_key_fingerprint" {
  description = "Fingerprint da chave SSH"
  value       = hcloud_ssh_key.k3s.fingerprint
}
