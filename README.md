# IaC mrosse.it

This repository contains the Infrastructure as Code (IaC) for the Kubernetes cluster hosted on Hetzner Cloud. We use Terraform with Terragrunt to manage our infrastructure in a modular and reusable way.

## Project Structure

```
.
├── root.hcl                # Terragrunt global configurations
├── infra/           # Environment-specific configurations
│   └── hetzner/           # Hetzner Cloud environment
│       ├── firewall/      # Firewall configuration
│       ├── instances/     # Instances configuration (control-plane and workers)
│       ├── loadbalancer/  # Load Balancer configuration
│       ├── network/       # Network configuration
│       └── ssh_key/       # SSH keys configuration
└── modules/               # Reusable Terraform modules
    └── hetzner/          # Hetzner-specific modules
        ├── firewall/     # Firewall module
        ├── instances/    # Instances module
        ├── loadbalancer/ # Load Balancer module
        ├── network/      # Network module
        └── ssh_key/      # SSH Keys module
```

## Prerequisites

- Terraform >= 1.0
- Terragrunt >= 0.45
- Hetzner Cloud account
- Hetzner Cloud API token

## Configuration

1. Set up your environment variables:
   ```bash
   export HCLOUD_TOKEN=your-token-here
   ```

2. Review and update configurations in:
   - `root.hcl` for global settings
   - `infra/hetzner/terragrunt.hcl` for environment-specific settings

## Usage

To apply the infrastructure:

1. Navigate to the desired environment directory:
   ```bash
   cd infra/hetzner
   ```

2. Apply all modules:
   ```bash
   terragrunt run-all apply
   ```

   Or apply specific modules:
   ```bash
   cd instances/
   terragrunt apply
   ```

## Modules

### Firewall (`modules/hetzner/firewall`)
- Manages cluster firewall rules
- Configurable via `firewall_rules` in terragrunt.hcl
- **Outputs**:
  - `firewall_id`: ID of the created firewall
  - `firewall_name`: Name of the firewall

### Instances (`modules/hetzner/instances`)
- Manages K3s cluster instances
- Supports multiple control-planes and workers
- Configurable via variables in terragrunt.hcl
- **Dependencies**:
  - Network module (for network configuration)
  - SSH Key module (for instance access)
  - Firewall module (for security rules)
- **Outputs**:
  - `control_plane_ips`: Public IPs of control plane nodes
  - `worker_ips`: Public IPs of worker nodes
  - `control_plane_private_ips`: Private IPs of control plane nodes
  - `worker_private_ips`: Private IPs of worker nodes
  - `control_plane_server_ids`: IDs of control plane servers
  - `inventory_path`: Path to generated Ansible inventory file

### Network (`modules/hetzner/network`)
- Configures private network for the cluster
- Defines IP ranges and subnets
- **Outputs**:
  - `network_id`: ID of the created network
  - `network_name`: Name of the network
  - `network_ip_range`: IP range of the network
  - `subnet_id`: ID of the created subnet

### Load Balancer (`modules/hetzner/loadbalancer`)
- Configures the cluster load balancer
- Manages HTTP/HTTPS endpoints

### SSH Keys (`modules/hetzner/ssh_key`)
- Manages SSH keys for instance access
- **Outputs**:
  - `ssh_key_id`: ID of the created SSH key
  - `ssh_key_name`: Name of the SSH key
  - `ssh_key_fingerprint`: Fingerprint of the SSH key

## Variable Structure

- Global variables: Defined in `root.hcl`
- Environment variables: Defined in `infra/hetzner/terragrunt.hcl`
- Specific variables: Defined in each environment module

## Dependency Management and Mock Outputs

Terragrunt uses dependencies to manage the order of resource creation and data sharing between modules. Mock outputs are used to handle dependency relationships during the planning phase, before actual resources exist.

### How Mock Outputs Work

1. **Dependency Declaration**: In a module's `terragrunt.hcl`, dependencies are declared using the `dependency` block:
   ```hcl
   dependency "network" {
     config_path = "../00-network"
     mock_outputs = {
       network_id = "mock-network-id"
       network_name = "k3s-network"
       network_ip_range = "10.0.0.0/16"
       subnet_id = "mock-subnet-id"
     }
   }
   ```

2. **Mock Output Values**:
   - Mock outputs provide temporary values during `plan` phase
   - Must match the structure of actual module outputs
   - Enable validation of configuration before resources exist
   - Help break circular dependencies

3. **When Mock Outputs are Used**:
   - During initial deployment when dependent resources don't exist
   - When running `terragrunt plan` on a fresh environment
   - When validating configurations

4. **Best Practices**:
   - Always include all outputs that your module references
   - Use realistic mock values that match expected formats
   - Keep mock values consistent across related modules
   - Document mock output requirements in module documentation

## Maintenance

To update the infrastructure:

1. Make necessary changes to configuration files
2. Run `terragrunt plan` to check changes
3. Run `terragrunt apply` to apply changes

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License

This project is under the MIT license.
