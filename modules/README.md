# Terraform Modules

This directory contains reusable Terraform modules for infrastructure provisioning on Hetzner Cloud.

## Directory Structure

```
.
└── hetzner/              # Hetzner Cloud specific modules
    ├── firewall/         # Manages firewall rules and configurations
    ├── k8s-instances/    # Handles VM instance provisioning
    ├── loadbalancer/     # Configures load balancer settings
    ├── network/          # Sets up private networks and subnets
    └── ssh_key/          # Manages SSH key pairs
```

## Available Modules

### Firewall
- Purpose: Manages firewall rules for K3s cluster
- Features:
  - Predefined rules for K3s communication
  - Customizable rules via variables
  - Support for both inbound and outbound rules

### Instances
- Purpose: Provisions and configures K3s nodes
- Features:
  - Control plane and worker node support
  - Cloud-init integration
  - Network attachment
  - Firewall association
  - Ansible inventory generation

### Load Balancer
- Purpose: Sets up load balancing for K3s API
- Features:
  - TCP/6443 endpoint for K3s API
  - Private network integration
  - Health checks
  - Server target support

### Network
- Purpose: Creates private network infrastructure
- Features:
  - Private network creation
  - Subnet management
  - IP range configuration
  - Network zone selection

### SSH Key
- Purpose: Manages SSH authentication
- Features:
  - SSH key pair management
  - Key import support
  - Multiple key management

## Usage

Each module can be used independently or as part of a larger infrastructure. See individual module directories for specific usage instructions and variable definitions.

Example usage in a Terragrunt configuration:

```hcl
terraform {
  source = "../../../../../../modules/hetzner/<module_name>"
}

inputs = {
  # Module specific variables
}
```

## Module Development

When developing or modifying modules:

1. Always include:
   - `main.tf` - Main module resources
   - `variables.tf` - Input variable definitions
   - `outputs.tf` - Output definitions

2. Follow best practices:
   - Use descriptive variable names
   - Include proper variable descriptions
   - Add validation rules where appropriate
   - Document any dependencies

3. Test modifications:
   - Use `terragrunt plan` to verify changes
   - Test all variable combinations
   - Verify outputs are correct
