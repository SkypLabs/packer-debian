# Packer Debian

This repository contains files used by [Packer][packer] to create Debian images for different hypervisors.

## Hypervisors supported

* VirtualBox (`vbox`)
* VMware (`vmware`)
* KVM (`kvm`)

## Vagrant support

In order to create an image to be used with [Vagrant][vagrant], you have to use one of these builders:

* `vbox4vagrant`
* `vmware4vagrant`
* `kvm4vagrant`

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

In addition, several variable files are available to precise which version of Debian should be used via the Packer `-var-file` option.

## Use this template behind a proxy

In order to use this template behind an *explicit proxy*, you need to add this last one in some files:

* In the preseed file:

        d-i mirror/http/proxy string <explicit proxy>

* In the `vagrant.sh` script, before the `curl` command:

        # Download the insecure public key from GitHub official repository
        export https_proxy=<explicit proxy>
        curl \
            --location \
            --output /home/vagrant/.ssh/authorized_keys \
            https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub

## Examples

To create an image of Debian 8 with all the hypervisors, including Vagrant images:

    packer build -var-file debian8.json packer-debian.json

To create a Vagrant Debian 8 image only with VirtualBox and overwrite some default variables' value (here, `headless` and `timeout`):

    packer build -only vbox4vagrant -var 'headless=false' -var 'timeout=1h' -var-file debian8.json packer-debian.json

## License

[MIT][license]

 [packer]: https://packer.io/
 [vagrant]: https://www.vagrantup.com/
 [license]: http://opensource.org/licenses/MIT
