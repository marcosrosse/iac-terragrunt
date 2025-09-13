variable "network_name" {
  description = "Network name"
  type        = string
}

variable "network_ip_range" {
  description = "Network IP range"
  type        = string
  default     = null
}

variable "subnet_ip_range" {
  description = "Subnet IP range"
  type        = string
  default     = null
}

variable "network_zone" {
  description = "Network zone"
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to apply to the network"
  type        = map(string)
  default     = {}
}
