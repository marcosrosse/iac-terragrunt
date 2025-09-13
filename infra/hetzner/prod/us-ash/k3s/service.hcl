locals {
    service_name = "k3s"

    # Network configuration
    network_ip_range = "10.0.0.0/8"
    subnet_ip_range  = "10.0.0.0/16"
    loadbalancer_ip = "10.0.1.100"
}