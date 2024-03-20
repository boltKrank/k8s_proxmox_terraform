# 2nd attempt

Try here: (https://github.com/Wirebrass/kubernetes-the-hard-way-on-proxmox)

Starting from scratch to get it running again.

Running off (https://www.linkedin.com/pulse/kubernetes-cluster-terraform-ansible-kris-unnikannan-7idre/) and using the TF module (https://github.com/frostyfab/terraform-provider-proxmox/tree/fix-memory-type-proxmox-8.0.4-workaround)


## Downloading Ubuntu image, editing it and making a VM from it:


```bash
wget -q https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
qemu-img resize jammy-server-cloudimg-amd64.img 32G
```

### Then

```bash
sudo qm create 8001 --name "ubuntu-2204-cloudinit-template" --ostype l26 \
    --memory 1024 \
    --agent 1 \
    --bios ovmf --machine q35 --efidisk0 local-zfs:0,pre-enrolled-keys=0 \
    --cpu host --socket 1 --cores 1 \
    --vga serial0 --serial0 socket  \
    --net0 virtio,bridge=vmbr0
```

### Create the cloud-init file

```bash
cat << EOF | sudo tee /var/lib/vz/snippets/vendor.yaml
#cloud-config
runcmd:
    - apt update
    - apt install -y qemu-guest-agent
    - systemctl start qemu-guest-agent
    - reboot
# Taken from https://forum.proxmox.com/threads/combining-custom-cloud-init-with-auto-generated.59008/page-3#post-428772
EOF
```

### Configure cloud-init

```bash
sudo qm set 8001 --cicustom "vendor=local:snippets/vendor.yaml"
sudo qm set 8001 --tags ubuntu-template,22.04,cloudinit
sudo qm set 8001 --ciuser untouchedwagons
sudo qm set 8001 --cipassword $(openssl passwd -6 $CLEARTEXT_PASSWORD)
sudo qm set 8001 --sshkeys ~/.ssh/authorized_keys
sudo qm set 8001 --ipconfig0 ip=dhcp
```

### Convert to template

```bash
sudo qm template 8001
```

