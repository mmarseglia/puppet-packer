node default {
  Exec {
      path => '/bin:/usr/bin:/sbin:/usr/sbin',
  }
  include archive
  include stdlib

  # install an older version of packer
  class { 'packer' :
    version => '0.7.5',
  }

  packer::plugin { 'post-processor-vagrant-vmware-ovf' :
      version   => 'v1.2.3';
  }
}
