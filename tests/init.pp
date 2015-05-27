node default {
  include packer

  packer::plugin { 'post-processor-vagrant-vmware-ovf' :
      version   => 'v1.2.3';
  }
}
