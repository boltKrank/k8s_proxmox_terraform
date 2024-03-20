#!/bin/bash
cd /root/img/k8s
cp orig_debian-12-generic-amd64.qcow2 debian-12-generic-amd64.qcow2 
apt update -y && apt install libguestfs-tools -y
qm destroy 8001
virt-customize -a debian-12-generic-amd64.qcow2 --root-password password:Happy3232
virt-customize -a debian-12-generic-amd64.qcow2 --upload interfaces:/etc/network/interfaces
virt-customize -a debian-12-generic-amd64.qcow2 --hostname 'gateway-01'
virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'apt-get update && apt-get upgrade -y'
virt-customize -a debian-12-generic-amd64.qcow2 --install qemu-guest-agent,wget,ssh,vim,tmux,curl,ntp,git,make #,iptables-persistent
# virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'apt-get install ssh vim tmux curl ntp iptables-persistent -y'
virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'systemctl enable qemu-guest-agent; systemctl start qemu-guest-agent; systemctl enable ntpsec; systemctl start ntpsec; systemctl enable ssh; systemctl start ssh'
virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'ssh-keygen -A; systemctl restart ssh.service'
# virt-customize -a debian-12-generic-amd64.qcow2 --run-command "echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf"
# virt-customize -a debian-12-generic-amd64.qcow2 --run-command "echo '1' > /proc/sys/net/ipv4/ip_forward"
# virt-customize -a debian-12-generic-amd64.qcow2 --upload rules.v4:/etc/iptables/rules.v4
# virt-customize -a debian-12-generic-amd64.qcow2 --upload hosts:/etc/hosts
virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'useradd tom'
virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'mkdir -p /home/tom/.ssh'
virt-customize -a debian-12-generic-amd64.qcow2 --ssh-inject tom:file:/home/tom/.ssh/id_tom_ed25519.pub
virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'chown -R tom:tom /home/tom'
virt-customize -a debian-12-generic-amd64.qcow2 --run-command '/sbin/usermod -aG sudo tom'
virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'echo "tom  ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/tom'
virt-customize -a debian-12-generic-amd64.qcow2 --run-command 'reboot'
qm create 8001 --name "debian12-gateway-template" --memory 4096 --sockets 1 --cores 2 --net0 virtio,bridge=vmbr0 --net1 virtio,bridge=vmbr8
qm importdisk 8001 debian-12-generic-amd64.qcow2 local-zfs
qm set 8001 --scsihw virtio-scsi-pci --scsi0 local-zfs:vm-8001-disk-0
qm disk resize 8001 scsi0 20G
qm set 8001 --boot c --bootdisk scsi0
qm set 8001 --ide2 local-zfs:cloudin
qm set 8001 --serial0 socket --vga serial0
qm set 8001 --agent enabled=1
qm template 8001