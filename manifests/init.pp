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
#  The version of Packer to install, defaults to '0.7.5'.
#
# [*bin_dir*]
#  The binary directory to place Packer in.  Defaults to '/usr/local/bin'.
#
# [*cache_dir*]
#  The directory to cache Packer release archives in.  Defaults to
#  '/tmp'.
#
class packer(
  $ensure    = 'installed',
  $version   = '0.7.5',
  $bin_dir   = $packer::params::bin_dir,
  $cache_dir = $packer::params::cache_dir,
) inherits packer::params {
  Exec {
    path => '/bin:/usr/bin:/sbin:/usr/sbin',
  }

  case $ensure {
    'present', 'installed': {

      if $::architecture in ['x86_64', 'amd64', 'x64'] {
        $arch = 'amd64'
      } else {
        $arch = '386'
      }

      if versioncmp($version, '0.7.0') >= 0 {
        $prefix = 'packer_'
      } else {
        $prefix = ''
      }

      $packer_basename = inline_template(
        "<%= \"#{@prefix}#{@version}_#{scope['::kernel'].downcase}_#{@arch}.zip\" %>"
      )

      $packer_url = "${packer::params::base_url}${packer_basename}"

      # Download the Packer zip archive to the cache.
      archive { $packer_basename :
        ensure            => present,
        url               => $packer_url,
        target            => $bin_dir,
        follow_redirects  => true,
        extension         => 'zip',
        checksum          => false,
        src_target        => $cache_dir,
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
