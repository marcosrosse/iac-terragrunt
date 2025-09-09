include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  # Carrega as variáveis do root.hcl
  root_vars = read_terragrunt_config(find_in_parent_folders("root.hcl"))
  root_config = local.root_vars
  region      = "fsn1"
  
  # Configurações específicas do ambiente Hetzner
  environment_config = {
    environment = "production"  # ou "staging", "development", etc.
    
    # Configurações de rede específicas do ambiente
    network_name = "${local.root_vars.locals.project_name}-network"
    subnet_ranges = {
      kubernetes = local.root_vars.locals.network_cidr
      vpn        = "10.100.0.0/24"
    }
    
    # Configurações padrão das instâncias
    default_image         = "ubuntu-22.04"
    default_location     = local.root_vars.locals.region
    ssh_keys            = ["your-ssh-key-name"]  # Lista de chaves SSH para usar
    
    # Labels/tags padrão para recursos
    labels = merge(local.root_vars.locals.common_tags, {
      Environment = "production"
    })
  }
}

inputs = {
  # Variáveis de ambiente
  region         = local.region
  project_name   = local.root_config.locals.project_name
  environment    = "prod"
  
  # Variáveis de rede
  network_cidr     = local.root_vars.locals.network_cidr
  vpn_subnet_cidr  = local.environment_config.subnet_ranges.vpn
  vpn_cidr         = "10.100.0.0/24"
  
  # Configurações de instância
  image            = local.environment_config.default_image
  default_image    = local.environment_config.default_image
  default_location = local.environment_config.default_location
  ssh_key_name     = "k3s-key"
  
  # Tags/labels
  labels          = merge(local.environment_config.labels, {
    Project     = local.root_config.locals.project_name
    Environment = "prod"
    ManagedBy   = "terragrunt"
  })
  
  # Outras configurações globais
  k8s_version     = local.root_vars.locals.k8s_version
}
