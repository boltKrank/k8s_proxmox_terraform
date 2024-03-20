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