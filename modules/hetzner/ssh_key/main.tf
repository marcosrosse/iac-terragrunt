resource "hcloud_ssh_key" "generic" {
  name       = var.ssh_key_name
  public_key = file(var.public_key_path)
  labels     = var.labels
}
