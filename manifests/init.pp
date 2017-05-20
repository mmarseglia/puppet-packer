# == Class: packer
#
# Installs Packer, the modern automated machine image creation tool.
#
# === Parameters
#
# [*ensure*]
#  Defaults to 'installed', if set to 'absent' will remove Packer.
#
# [*version*]
#  The version of Packer to install, defaults to 0.10.1
#
# [*bin_dir*]
#  The binary directory to place Packer in.  Defaults to '/usr/local/bin'.
#
# [*cache_dir*]
#  The directory to cache Packer release archives in.  Defaults to
#  '/tmp'.
#
class packer(
  String $ensure    = $packer::params::ensure,
  String $version   = $packer::params::version,
  String $bin_dir   = $packer::params::bin_dir,
  String $cache_dir = $packer::params::cache_dir,
  String $base_url  = $packer::params::base_url,
  String $proxy     = $packer::params::proxy,
) inherits packer::params {

  case $ensure {
    'present', 'installed': {
      # if the installed version does not match what we specify then install
      # that version of packer.
      if versioncmp($version, $::packer_version) > 0 {

        if $::architecture in ['x86_64', 'amd64', 'x64'] {
          $arch = 'amd64'
        } else {
          $arch = '386'
        }
        $kernel_l = downcase($::kernel)  
        $installer = "packer_${version}_${kernel_l}_${arch}.zip"

        # Download the Packer zip archive to the cache.
        archive { "${cache_dir}/${installer}" :
          ensure          => present,
          extract         => true,
          extract_path    => $bin_dir,
          source          => "${base_url}/${version}/${installer}",
          checksum_verify => false,
          cleanup         => true,
          proxy_server    => $proxy,
        }
      }
    }
    'absent', 'uninstalled': {
      # Ensure the binaries are removed.
      $binaries = prefix(
        [
          'packer',
          'packer-builder-amazon-chroot',
          'packer-builder-amazon-ebs',
          'packer-builder-amazon-instance',
          'packer-builder-digitalocean',
          'packer-builder-docker',
          'packer-builder-googlecompute',
          'packer-builder-null',
          'packer-builder-openstack',
          'packer-builder-parallels-iso',
          'packer-builder-parallels-pvm',
          'packer-builder-qemu',
          'packer-builder-virtualbox-iso',
          'packer-builder-virtualbox-ovf',
          'packer-builder-vmware-iso',
          'packer-builder-vmware-vmx',
          'packer-post-processor-atlas',
          'packer-post-processor-compress',
          'packer-post-processor-docker-import',
          'packer-post-processor-docker-push',
          'packer-post-processor-docker-save',
          'packer-post-processor-docker-tag',
          'packer-post-processor-vagrant',
          'packer-post-processor-vagrant-cloud',
          'packer-post-processor-vsphere',
          'packer-provisioner-ansible-local',
          'packer-provisioner-chef-client',
          'packer-provisioner-chef-solo',
          'packer-provisioner-file',
          'packer-provisioner-puppet-masterless',
          'packer-provisioner-puppet-server',
          'packer-provisioner-salt-masterless',
          'packer-provisioner-shell',
        ],
        "${bin_dir}/"
      )

      file { $binaries:
        ensure => absent,
      }
    }
    default: {
      fail("Invalid ensure value for packer: ${ensure}.\n")
    }
  }
}
