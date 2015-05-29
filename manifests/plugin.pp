# === packer::plugin
#
# This class will install plugins for packer.
#
# [*version*]
# Packer plugin version string.
#
define packer::plugin (
  $ensure     = 'present',
  $version    = UNDEF,
) {

  include ::packer::params

  validate_string($name)
  validate_string($ensure)

  if $version == undef {
    fail("Plugin ${name} version is undefined. You must specify a version")
  }

  $bin_dir    = $::packer::params::bin_dir
  $cache_dir  = $::packer::params::cache_dir

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

        archive { $file :
          ensure           => present,
          target           => $bin_dir,
          follow_redirects => true,
          url              => $url,
          checksum         => false,
          src_target       => $cache_dir,
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
