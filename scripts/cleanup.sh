#!/usr/bin/env bash

# Stop cron service
service cron stop

# Stop logging services
service rsyslog stop

# Clean out apt
apt-get -y --purge autoremove
apt-get -y clean

# Force the logs to rotate and remove old logs we don’t need
logrotate -f /etc/logrotate.conf
rm -f /var/log/*.1

# Truncate the audit logs
cat /dev/null > /var/log/wtmp
cat /dev/null > /var/log/lastlog
cat /dev/null > /var/log/grubby

# Remove the udev persistent device rules
rm -f /etc/udev/rules.d/70-persistent-*.rules

# Remove the apt proxy configuration
sed '/^Acquire::http::Proxy/d' -i /etc/apt/apt.conf

# Clean /tmp out
rm -rf /tmp/*
rm -rf /var/tmp/*

# Remove the SSH host keys
# They will be regenerated for each instance
# at startup by the sshd-keygen.service
rm -f /etc/ssh/*key*

# Remove root user's SSH files
rm -rf ~root/.ssh/

# Remove the root user’s shell history
rm -f ~root/.bash_history
unset HISTFILE

# Remove installation logs
rm -rf /var/log/installer
