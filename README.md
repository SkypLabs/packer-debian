# Packer Debian

This repository contains files used by [Packer][1] to create Debian images for different hypervisors.

## Hypervisors supported

* VirtualBox (vbox)
* VMware (vmware)
* KVM (kvm)

## Vagrant support

In order to create an image to be used by [Vagrant][2], you have to use one of these builders :

* vbox4vagrant
* vmware4vagrant
* kvm4vagrant

## Variables available

    Optional variables and their defaults:

      build_number      = {{timestamp}}
      debian_arch       = amd64
      disk_size         = 10000
      headless          = true
      iso_base_url      = http://cdimage.debian.org/debian-cd
      iso_checksum_type = sha256
      password          = password
      timeout           = 30m
      username          = root

In addition, several variables files are available in order to precise which version of Debian you want to use. The Packer *-var-file* option has to be used with one of these files.

## Use this template behind a proxy

In order to use this template behind an *explicit proxy*, you have to add this last in some files :

* In the preseed file :

        d-i mirror/http/proxy string <explicit proxy>

* In the vagrant.sh script, before the curl command :

        # Download the insecure public key from GitHub official repository
        export https_proxy=<explicit proxy>
        curl \
            --location \
            --output /home/vagrant/.ssh/authorized_keys \
            https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub

## Examples

To create an image of Debian 8 for all the hypervisors, including images with Vagrant support :

    packer build -var-file debian8.json packer-debian.json

To create an Debian 8 image only for VirtualBox with Vagrant support and some default variable values overwritten, for example, *headless* and *timeout* :

    packer build -only vbox4vagrant -var 'headless=false' -var 'timeout=1h' -var-file debian8.json packer-debian.json

## License

[MIT][3]

 [1]: https://packer.io/
 [2]: https://www.vagrantup.com/
 [3]: http://opensource.org/licenses/MIT
