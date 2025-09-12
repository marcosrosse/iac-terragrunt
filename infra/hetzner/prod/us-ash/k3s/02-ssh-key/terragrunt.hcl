include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../modules/hetzner/ssh_key"
}

inputs = {
  ssh_key_name    = "k3s-key"
  public_key_path = "~/.ssh/id_ed25519.pub"
  labels = {
    Name        = "k3s-key"
    Environment = "prod"
    ManagedBy   = "terragrunt"
  }
}
