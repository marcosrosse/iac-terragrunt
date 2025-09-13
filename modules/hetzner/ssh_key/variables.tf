variable "ssh_key_name" {
  description = "SSH Key name"
  type        = string
}

variable "public_key_path" {
  description = "SSH Public Key path"
  type        = string
}

variable "labels" {
  description = "Labels to apply to the SSH Key"
  type        = map(string)
  default     = {}
}
