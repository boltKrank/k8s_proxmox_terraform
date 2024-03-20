variable "proxmox_host" {
    default = "pve"
}
variable "template_name" {
  type = string
}

variable "pm_api_url" {
  type = string
}

variable "pm_api_token_id" {
  type = string
}

variable "pm_api_token_secret" {
  type = string
}

variable "pm_ip" {
  type = string
}

variable "ssh_user" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "ssh_user_password" {
  type = string
}

variable "gateway_vm_name" {
  type = string
}

variable "internal_bridge" {
  type = string
}

variable "external_bridge" {
  type = string
}