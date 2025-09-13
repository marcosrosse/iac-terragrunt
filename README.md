# IaC - Terragrunt

This repository contains infrastructure as code (IaC) for Kubernetes clusters hosted on the Hetzner Cloud. We use Terraform with Terragrunt to manage our infrastructure in a modular and reusable way.

## 🏗️ Project Structure

```
.
├── root.hcl                                  # Global Terragrunt Settings
├── infra/                                    # Environment-Specific Settings
│   └── hetzner/                              # Hetzner Cloud Environment
│       ├── provider.hcl                      # Provider Settings
│       └── prod/                             # Production Environment
│           ├── environment.hcl               # Environment Variables
│           └── us-ash/                       # us-ash Region
│               ├── region.hcl                # Region Variables
│               └── k3s/                      # K3s Service
│                   ├── service.hcl           # Service Variables
│                   ├── 00-network/           # Network Configuration
│                   ├── 01-firewall/          # Firewall Configuration
│                   ├── 02-ssh-key/           # SSH Key Configuration
│                   ├── 03-instances/         # Instance Configuration
│                   └── 04-loadbalancer/      # Load Balancer Configuration
└── modules/                                  # Reusable Terraform Modules
    └── hetzner/                              # Hetzner-Specific Modules
        ├── firewall/                         # Firewall Module
        ├── k8s-instances/                    # Instance Module
        ├── loadbalancer/                     # Load Balancer Module
        ├── network/                          # Network Module
        └── ssh_key/                          # SSH Key Module
```

## 🚀 Prerequisites

- **Terraform** >= 1.5.0
- **Terragrunt** >= 0.45.0
- **Hetzner Cloud Account**
- **Hetzner API Token Cloud**

## ⚙️ Configuration

### 1. Environment Variables

```bash
export HCLOUD_TOKEN=your-token-here
```

### 2. Hierarchical Configuration Structure

The project uses a hierarchical structure where each level inherits and can override settings from higher levels:

```
root.hcl (global)
└── provider.hcl (provider-specific)
    └── environment.hcl (environment-specific)
        └── region.hcl (region-specific)
            └── service.hcl (service-specific)
```

#### Example Settings:

**root.hcl**: Global settings and default labels
**provider.hcl**: Hetzner-specific configurations
**environment.hcl**: `environment = "production"`
**region.hcl**: `region = "ash"`, `zone = "us-west"`
**service.hcl**: `service_name = "k3s"`, network config

## 🛠️ How to Use

### Apply All Infrastructure

```bash
cd infra/hetzner/prod/us-ash/k3s
terragrunt apply --all
```

### Apply Specific Modules

```bash
cd infra/hetzner/prod/us-ash/k3s/00-network
terragrunt apply

cd ../03-instances
terragrunt apply
```

### Verify Changes

```bash
cd infra/hetzner/prod/us-ash/k3s
terragrunt plan  --all
```

## 🏷️ Labels

All resources are automatically tagged with default labels:

```hcl
labels = {
  environment = "production"
  service     = "k3s"
  region      = "ash"
  zone        = "us-west"
  managed_by  = "terragrunt"
}
```

## 🔧 Maintenance

To update the infrastructure:

1. Make necessary changes to configuration files
2. Run `terragrunt plan` to check changes
3. Run `terragrunt apply` to apply changes

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📄 License

This project is under the MIT license.
