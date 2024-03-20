terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"    
    }
  }
}


provider "proxmox" {

  pm_api_url = var.pm_api_url
  pm_api_token_id = var.pm_api_token_id  
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure = true
  pm_debug = false
  pm_parallel = 10

}

# Prep the template
resource "terraform_data" "template-prep" {

  connection {
    type = "ssh"
    user = "root"
    private_key = file("${path.module}/keys/root.pem")
    host = var.pm_ip
  }

  provisioner "remote-exec" {
    inline = [ "/root/img/k8s/gateway_template_debian12.sh"  ]    
  }
  
}


resource "proxmox_vm_qemu" "gateway-vm" {

  name = var.gateway_vm_name
  desc = "VM for bootstrapping"
  target_node = var.proxmox_host

  ## Clone from existing VM
  clone = var.template_name
  agent = 1
  os_type = "cloud-init"
  cores = 2  
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
  
  disks {
    scsi {
      scsi0 {
        disk {
          size = 20
          storage = "local-zfs"
        }
      }
    }
  }

  # External bridge
  network {
    model = "virtio"
    bridge = var.external_bridge    
    macaddr = "b6:c1:18:57:0e:7f"
  }

  # Internal k8s bridge
  network {
    model = "virtio"
    bridge = var.internal_bridge
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }

  define_connection_info = true

  os_network_config = <<EOF

  EOF

  connection {
    type = "ssh"
    user = var.ssh_user
    private_key = file("${path.module}/keys/tom.pem")
    host = self.default_ipv4_address
  }

  provisioner "remote-exec" {
    inline = [ "wget https://go.dev/dl/go1.22.1.linux-amd64.tar.gz",
               "sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz",
               "export PATH=$PATH:/usr/local/go/bin",
               "go version",               
               "git clone https://github.com/cloudflare/cfssl.git",
               "cd cfssl",
               "make",
               "go get github.com/cloudflare/cfssl/cmd/cfssl",
               "go get github.com/cloudflare/cfssl/cmd/cfssljson",
               "cd bin",
               "sudo cp cfssl /usr/local/bin",
               "sudo cp cfssljson /usr/local/bin",
               "curl -LO 'https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl'",
               "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl"
            ]  
  }

}