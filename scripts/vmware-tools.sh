#!/usr/bin/env bash

# Install dependencies
apt-get update && apt-get install -y gcc make binutils linux-headers-$(uname -r)

# Mount VMware Tools ISO file
mkdir /mnt/vmware
mount -t iso9660 -o loop /root/linux.iso /mnt/vmware

# Execute the installer
cd /tmp
cp /mnt/vmware/VMwareTools-*.gz .
tar zxvf VMwareTools-*.gz
./vmware-tools-distrib/vmware-install.pl -d

# Unmount ISO file
umount /mnt/vmware
rmdir /mnt/vmware

# Delete ISO file
rm -f /root/linux.iso

# Delete copied files from ISO
rm -rf VMwareTools-.gz vmware-tools-distrib
