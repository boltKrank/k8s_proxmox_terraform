# resource "proxmox_vm_qemu" "controller-vm" {

# #   depends_on = [ proxmox_vm_qemu.bootstrap-vm
# #    ]

#   count = var.controller_count
#   name = "kube-controller-0${count.index + 1}"
#   target_node = var.proxmox_host

#   ## Clone from existing VM
#   clone = var.template_name
#   agent = 1
#   os_type = "cloud-init"
#   cores = var.bootstrap_cores
#   sockets = var.bootstrap_sockets
#   cpu = "host"
#   memory = var.bootstrap_memory
#   scsihw = "virtio-scsi-pci"
#   bootdisk = "scsi0"

#   ciuser = var.ssh_user
#   cipassword = var.ssh_user_password
  
#   disks {
#     scsi {
#       scsi0 {
#         disk {
#           size = var.bootstrap_hdd_size
#           storage = "local-zfs"
#         }
#       }
#     }
#   }

#   # if you want two NICs, just copy this whole network section and duplicate it
# #   network {
# #     model = "virtio"
# #     bridge = "vmbr0"
# #     # macaddr = "b6:c1:18:57:0e:7f"
# #   }

#   network {
#     model = "virtio"
#     bridge = "vmbr10"
#     # macaddr = "b6:c1:18:57:0e:7f"
#   }

#   lifecycle {
#     ignore_changes = [
#       network,
#     ]
#   }

#   # The main LAN network is 192.168.0.0/24. gw=192.168.20.1, and the Kube internal network (on its own bridge) is 10.20.0.0/24.

#   # ipconfig0 = "ip=192.168.20.8${count.index + 1}/24,gw=192.168.20.1"
#   ipconfig0 = "ip=10.240.0.5${count.index + 1}/24"

#   #TODO: https://pve.proxmox.com/pve-docs/chapter-sysadmin.html#_routed_configuration

#   sshkeys = <<EOF
#   ${var.ssh_public_key}
#   EOF

# }