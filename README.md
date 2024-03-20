# k8s_proxmox_terraform
Terraform automation of k8s environment on Proxmox

## DNSmasq on proxmox

See (https://pve.proxmox.com/wiki/Setup_Simple_Zone_With_SNAT_and_DHCP)



### TODO

(https://www.linkedin.com/pulse/kubernetes-cluster-terraform-ansible-kris-unnikannan-7idre/)


### NOTES

# 3rd time lucky

(https://github.com/Wirebrass/kubernetes-the-hard-way-on-proxmox)

Going off this guide.


## Step 1

Create 2 bridges

1. vmbr0 (Gateway and public)
2. vmbr8 (All the k8s boxes are on this) - 192.168.


## Machines

7 machines are going to be made:

801 - k8s-gateway-01
810 - k8s-controller-0
811 - k8s-controller-1
812 - k8s-controller-2
820 - k8s-worker-0
821 - k8s-worker-1
822 - k8s-worker-2

## Gateway

edit `/etc/network/interfaces` on the gateway VM:

```bash
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The public network interface
auto ens18
allow-hotplug ens18
iface ens18 inet static
        address PUBLIC_IP_ADDRESS/MASK
        gateway PUBLIC_IP_GATEWAY
        dns-nameservers 9.9.9.9

# The private network interface
auto ens19
allow-hotplug ens19
iface ens19 inet static
        address 192.168.8.1/24
        dns-nameservers 9.9.9.9
```

TODO: (https://github.com/Wirebrass/kubernetes-the-hard-way-on-proxmox/blob/master/docs/03-compute-resources.md)


### Extra notes


# Gateway

## Prep

Create bridge vmbr8 (192.168.8.0/24) -  port = ens19  (.1)

vmbr0 (ip=192.168.20.35/24, gw=192.168.20.1)  - port = ens18 (PUBLIC_IP)

## VM Hardware

- 2Gb memory
- 1 vCPU
- 20Gb storage
- 2 x NIC

## Add user to sudoers

su
/sbin/usermod -aG sudo <username>
sudo visudo

add:

<username> ALL=(ALL:ALL) ALL

to the end


## Interfaces

```bash
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The public network interface
auto ens18
allow-hotplug ens18
iface ens18 inet static
        address PUBLIC_IP_ADDRESS/MASK
        gateway PUBLIC_IP_GATEWAY
        dns-nameservers 9.9.9.9

# The private network interface
auto ens19
allow-hotplug ens19
iface ens19 inet static
        address 192.168.8.1/24
        dns-nameservers 9.9.9.9

```