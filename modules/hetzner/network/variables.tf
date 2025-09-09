variable "network_name" {
  description = "Nome da rede privada"
  type        = string
}

variable "network_ip_range" {
  description = "Range de IP da rede privada"
  type        = string
  default     = "10.0.0.0/8"
}

variable "subnet_ip_range" {
  description = "Range de IP da subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "network_zone" {
  description = "Zona da rede"
  type        = string
  default     = "eu-central"
}

variable "labels" {
  description = "Labels para o recurso"
  type        = map(string)
  default     = {}
}
