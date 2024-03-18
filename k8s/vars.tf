variable "proxmox_host" {
    type = string
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

variable "ssh_user" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "bootstrap_vm_name" {
  type = string
}

variable "ssh_user_password" {
  type = string
}

# Bootstrap

variable "bootstrap_hdd_size" {
  type = number
}

# K8S

variable "controller_hdd_size" {
  type = number
}

variable "worker_hdd_size" {
  type = number
}

variable "controller_memory" {
  type = number
}

variable "worker_memory" {
  type = number
}

variable "k8s_bridge" {
  type = string
}

variable "controller_count" {
  type = number
}

variable "worker_count" {
  type = number  
}

variable "bootstrap_sockets" {
  type = number
}

variable "bootstrap_cores" {
  type = number
}

variable "bootstrap_memory" {
  type = number
}

variable "bootstrap_network_bridge" {
  type = string
}

variable "bootstrap_mac_address" {
  type = string
}