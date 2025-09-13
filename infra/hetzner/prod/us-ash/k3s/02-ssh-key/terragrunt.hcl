include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../../../../modules/hetzner/ssh_key"
}

locals {
  labels = merge(
    include.root.inputs.labels,
    {
      type = "ssh-key"
      region = "global"
    }
  )
}

inputs = {
  ssh_key_name    = "${include.root.inputs.service_name}-key"
  public_key_path = "~/.ssh/id_ed25519.pub"
  labels = local.labels
}
