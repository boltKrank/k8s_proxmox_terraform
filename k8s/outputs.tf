# output "bootstrap_vm_ip" {
#     description = "The IP of the machine provisioned"
#     value = proxmox_vm_qemu.bootstrap-vm.default_ipv4_address
# }

output "controller_vm_list" {
  value = [
    for host in proxmox_vm_qemu.controller-vm : {
      "name" : host.name
      "ip0" : host.ssh_host,
      "memory" : host.memory,
      "vcpus" : host.vcpus
    }
  ]
}

# output "worker_vm_list" {
#   value = [
#     for host in proxmox_vm_qemu.worker-vm : {
#       "name" : host.name
#       "ip0" : host.ssh_host,
#       "memory" : host.memory,
#       "vcpus" : host.vcpus
#     }
#   ]
# }