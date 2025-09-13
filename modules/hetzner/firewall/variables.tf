variable "firewall_name" {
  description = "Firewall name"
  type        = string
}

variable "firewall_rules" {
  description = "Firewall rules"
  type = list(object({
    direction   = string
    protocol    = string
    port        = string
    source_ips  = list(string)
    description = optional(string)
  }))
}

variable "labels" {
  description = "Labels to apply to the firewall"
  type        = map(string)
  default     = {}
}
