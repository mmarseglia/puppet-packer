require 'spec_helper'

describe 'packer::plugin' do
  let(:facts) { { architecture: 'x86_64', kernel: 'Linux', puppetversion: '3.6.2 (Puppet Enterprise 3.3.2)', osfamily: 'RedHat' } }

  # required for module archive
  let(:environment) { 'production' }

  let(:params) { { version: 'v.1.2.3' } }

  context 'with defaults for all parameters' do
    let(:title) { 'myplug' }

    it { is_expected.to compile }
  end
end
