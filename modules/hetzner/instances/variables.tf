variable "control_plane_count" {
  description = "Number of control plane instances"
  type        = number
  default     = 1
}

variable "worker_count" {
  description = "Number of worker instances"
  type        = number
  default     = 2
}

variable "instance_prefix" {
  description = "Name prefix for all instances"
  type        = string
  default     = "k3s"
}

variable "image" {
  description = "Image to be used for instances"
  type        = string
}

variable "control_plane_type" {
  description = "Server type for control plane nodes"
  type        = string
}

variable "worker_type" {
  description = "Server type for worker nodes"
  type        = string
}

variable "location" {
  description = "Location for instances"
  type        = string
}

variable "user_data_template_path" {
  description = "Path to cloud-init template"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH key name to be used"
  type        = string
}

variable "network_name" {
  description = "Private network name"
  type        = string
}

variable "labels" {
  description = "Labels for instances"
  type        = map(string)
  default     = {}
}

variable "firewall_name" {
  description = "Name of the firewall to be applied to instances"
  type        = string
}

variable "inventory_file_path" {
  description = "Full path where inventory.yaml file will be saved"
  type        = string
}
