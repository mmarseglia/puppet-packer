# === Class packer:params
# Provides default parameters for classes.
#
# [*base_url*]
#  The base download URL to retrieve Packer from, including a
#  a trailing '/'.  Defaults to: 'https://releases.hashicorp.com/packer/'
#
class packer::params {

  ensure_resource('class', 'stdlib')

  $base_url  = 'https://releases.hashicorp.com/packer/'

  case downcase($::kernel) {
    'windows' : {
      $bin_dir    = 'C:\WINDOWS\system32'
      $cache_dir  = 'C:\TEMP'
    }
    /^(linux|darwin)$/ : {
      $bin_dir   = '/usr/local/bin'
      $cache_dir = '/tmp'
    }
    default : {
      notice ( 'Operating system $::kernel not supported, trying defaults.')
      $bin_dir   = '/usr/local/bin'
      $cache_dir = '/tmp'
    }
  }
}
