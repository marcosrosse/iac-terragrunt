locals {
  # These files MUST exist and have the keys shown below.
  region_vars       = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  service_vars      = read_terragrunt_config(find_in_parent_folders("service.hcl"))
  provider_vars     = read_terragrunt_config(find_in_parent_folders("provider.hcl"))
  environment_vars  = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  # Unified, default labels for the whole repo
  labels = {
    environment  = local.environment_vars.locals.environment
    service      = local.service_vars.locals.service_name
    region       = local.region_vars.locals.region
    zone         = local.region_vars.locals.zone
    managed_by   = "terragrunt"
  }
}

# Terragrunt-managed state
remote_state {
  backend = "local"
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# Ensure there's a backend block in TF code
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      backend "local" {}
    }
  EOF
}

# Terraform version + provider
generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      required_version = ">= 1.5.0"
      required_providers {
        hcloud = {
          source  = "hetznercloud/hcloud"
          version = ">= 1.45.0"
        }
      }
    }
  EOF
}

# Hetzner provider (uses HCLOUD_TOKEN from environment)
generate "provider_hcloud" {
  path      = "provider-hcloud.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    provider "hcloud" {}
  EOF
}

# Expose everything downstream (including the labels map)
inputs = merge(
  local.region_vars.locals,
  local.service_vars.locals,
  local.provider_vars.locals,
  local.environment_vars.locals,
  { labels = local.labels }
)
