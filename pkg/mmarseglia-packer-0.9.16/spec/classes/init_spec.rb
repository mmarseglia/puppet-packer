require 'spec_helper'

describe 'packer' do
				let(:facts) { {:architecture => 'x86_64', :kernel => 'Linux', :puppetversion => '3.6.2 (Puppet Enterprise 3.3.2)', :osfamily => 'RedHat' } }

				# required for module archive
				let(:environment) { 'production' }

				it { should compile }
				it { should contain_class('packer') }
				it { should contain_archive('/tmp/packer_0.7.5_linux_amd64.zip') }
end
