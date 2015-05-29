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

  $bin_dir    = $::packer::params::bin_dir
  $cache_dir  = $::packer::params::cache_dir

  if $::architecture in ['x86_64', 'amd64', 'x64'] {
    $arch = 'amd64'
  } else {
    $arch = 'i386'
  }

  validate_string($name)
  validate_string($version)
  validate_string($ensure)

  case $name {
    'post-processor-vagrant-vmware-ovf' : {
      if $ensure in 'present' {
        $file = inline_template(
          "<%= \"packer-#{@name}.#{scope['::kernel'].downcase}-#{@arch}.tar.gz\" %>"
        )
        $url = "https://github.com/gosddc/packer-${name}/releases/download/${version}/"

        archive { $file :
          ensure           => present,
          target           => $bin_dir,
          follow_redirects => true,
          url              => "${url}${file}",
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
