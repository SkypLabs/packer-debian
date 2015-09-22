#!/usr/bin/env bash

# Install dependencies
apt-get update && apt-get install -y gcc make linux-headers-$(uname -r)

# Mount Guest Additions ISO file
mkdir /mnt/vbox
mount -t iso9660 -o loop /root/VBoxGuestAdditions.iso /mnt/vbox

# Execute the installer
/mnt/vbox/VBoxLinuxAdditions.run

# Display installation logs before deleting them
cat /var/log/vboxadd-install.log
rm -f /var/log/vboxadd-install*.log
rm -f /var/log/VBoxGuestAdditions.log

# Unmount ISO file
umount /mnt/vbox
rmdir /mnt/vbox

# Delete ISO file
rm -f /root/VBoxGuestAdditions.iso
