# === Class packer:params
# Provides default parameters for classes.
#
# [*base_url*]
#  The base download URL to retrieve Packer from, including a
#  a trailing '/'.  Defaults to: 'https://releases.hashicorp.com/packer/'
#
class packer::params {
  $base_url  = 'https://releases.hashicorp.com/packer'
  $ensure    = 'installed'
  $version   = '1.0.0'
  $proxy     = undef

  case downcase($::kernel) {
    'windows' : {
      $bin_dir    = 'C:\WINDOWS\system32'
      $cache_dir  = 'C:\TEMP'
    }
    default : {
      Exec {
        path => '/bin:/usr/bin:/sbin:/usr/sbin',
      }
      $bin_dir   = '/usr/local/bin'
      $cache_dir = '/tmp'
    }
  } 
}
