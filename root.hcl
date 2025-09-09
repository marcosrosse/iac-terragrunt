locals {
  # Configurações globais
  project_name = "k3s-cluster"
  region      = "fsn1"  # Região padrão Hetzner (Falkenstein)
  
  # Tags comuns para todos os recursos
  common_tags = {
    Project     = local.project_name
    ManagedBy   = "terragrunt"
  }

  # Configurações de rede
  network_cidr = "10.0.0.0/16"
  
  # Configurações do Kubernetes
  k8s_version = "v1.27"
}

# Generate providers config
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.45.0"
    }
  }
  required_version = ">= 1.0"

  # Empty backend block that will be configured by Terragrunt
  backend "local" {}
}

provider "hcloud" {}
EOF
}

# Configuração do backend remoto
remote_state {
  backend = "local"
  config = {
    path = "${path_relative_to_include()}/terraform.tfstate"
  }
}
