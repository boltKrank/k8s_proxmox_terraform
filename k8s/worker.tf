# resource "proxmox_vm_qemu" "worker-vm" {

#   depends_on = [ proxmox_vm_qemu.bootstrap-vm
#    ]

#   count = var.worker_count
#   name = "kube-worker-0${count.index + 1}"
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
#       network 
#     ]
#   }

#   # define_connection_info = true

# #   os_network_config = <<EOF
# #     auto eth0
# #     iface eth0 inet dhcp
# #   EOF

# }