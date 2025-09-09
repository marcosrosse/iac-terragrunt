variable "ssh_key_name" {
  description = "Nome da chave SSH"
  type        = string
}

variable "public_key_path" {
  description = "Caminho para o arquivo da chave pública SSH"
  type        = string
}

variable "labels" {
  description = "Labels para o recurso"
  type        = map(string)
  default     = {}
}
