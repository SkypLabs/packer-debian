#!/usr/bin/env bash

# Install dependencies
apt-get update && apt-get install -y gcc make perl linux-headers-$(uname -r)

# Mount Guest Additions ISO file
mount -t iso9660 -o loop /root/VBoxGuestAdditions.iso /mnt

# Execute the installer
/mnt/VBoxLinuxAdditions.run

# Display installation logs before deleting them
cat /var/log/vboxadd-install.log
rm -f /var/log/vboxadd-install*.log
rm -f /var/log/VBoxGuestAdditions.log

# Unmount ISO file
umount /mnt

# Delete ISO file
rm -f /root/VBoxGuestAdditions.iso
