output "gateway_vm_ip" {
    description = "The IP of the machine provisioned"
    value = proxmox_vm_qemu.gateway-vm.default_ipv4_address
}

