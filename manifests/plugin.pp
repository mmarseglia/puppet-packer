# === packer::plugin
#
# This class will install plugins for packer.
#
# [*version*]
# Packer plugin version string.
#
define packer::plugin (
  $ensure     = 'present',
  $version    = '',
) {

  if $version == undef {
    fail("Plugin ${name} version is undefined. You must specify a version")
  }

  $bin_dir    = lookup('packer::bin_dir')
  $cache_dir  = lookup('packer::cache_dir')

  if $::architecture in ['x86_64', 'amd64', 'x64'] {
    $arch = 'amd64'
  } else {
    $arch = 'i386'
  }

  case $name {
    'post-processor-vagrant-vmware-ovf' : {
      if $ensure in 'present' {
        $file = inline_template(
          "<%= \"packer-#{@name}.#{scope['::kernel'].downcase}-#{@arch}\" %>"
        )
        $base_url = "https://github.com/gosddc/packer-${name}/releases/download/${version}/"

        $url = "${base_url}${file}.tar.gz"

        archive { "${cache_dir}/${file}" :
          ensure          => present,
          extract_path    => $bin_dir,
          source          => $url,
          checksum_verify => false,
        }
      } elsif $ensure in 'absent' {
        file { "${bin_dir}/packer-${name}" :
          ensure  => absent,
        }
      }
    }

    default : {
      notice ("Unknown plugin ${name}.")
    }
  }
}
