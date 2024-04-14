#!/bin/bash

# Frissitjük a rendszert

update_system() {
    echo "Hello Radius Elsőnek frissitem a szervert!"
    sudo apt-get update
    sudo apt-get upgrade -y
}

# Adatok bekérése 
echo "Kérlek ad meg a szükséges adatokért"
read -p "Használt port: " use_port
read -p "IP cím: " ip_address
read -p "Hálózati maszk: " netmask
read -p "Átjáró címe: " gateway
read -p "DNS szerver címe: " dns

# Konfog fájl modosítása 
update_config_file() {
    source_config_path="config_raw.txt" #ez a nyers fájl
    destination_config_path="/etc/netplan/01-netcfg.yaml"
{
    echo "network:"
        echo "    version: 2"
        echo "    ethernets:"
        echo "      [${use_port}]:"
        echo "            dhcp4: no"
        echo "            addresses: [${ip_address}/24]"
        echo "            gateway4: ${gateway}"
        echo "            nameservers:"
        echo "                addresses: [${dns}]"
    } > "${destination_config_path}"
}

#Fügvények futtatása
update_system
update_config_file

echo "A frissités megtörtént az IP cím beállítások megtörténtek"
