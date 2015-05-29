node default {
  Exec {
      path => '/bin:/usr/bin:/sbin:/usr/sbin',
  }
  include archive
  include stdlib

  include packer

  packer::plugin { 'post-processor-vagrant-vmware-ovf' :
      version   => 'v1.2.3';
  }
}
