variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "network_id" {
  description = "ID of the network where the load balancer will be connected"
  type        = string
}

variable "loadbalancer_ip" {
  description = "Load balancer IP in the private network"
  type        = string
  default     = null
}

variable "location" {
  description = "Load balancer location"
  type        = string
  default     = null
}

variable "server_ids" {
  description = "IDs of the servers that will be load balancer targets"
  type        = list(string)
}

variable "algorithm_type" {
  description = "Load balancer algorithm type"
  type        = string
  default     = "round_robin"
}

variable "protocol" {
  description = "Service protocol"
  type        = string
  default     = "tcp"
}

variable "listen_port" {
  description = "Port that the load balancer will listen on"
  type        = number
}

variable "target_port" {
  description = "Target servers port"
  type        = number
}

variable "labels" {
  description = "Resource labels"
  type        = map(string)
  default     = {}
}