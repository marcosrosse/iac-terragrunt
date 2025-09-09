variable "firewall_name" {
  description = "Nome do firewall"
  type        = string
}

variable "firewall_rules" {
  description = "Lista de regras do firewall"
  type = list(object({
    direction   = string
    protocol    = string
    port        = string
    source_ips  = list(string)
    description = optional(string)
  }))
}

variable "labels" {
  description = "Labels para o recurso"
  type        = map(string)
  default     = {}
}
