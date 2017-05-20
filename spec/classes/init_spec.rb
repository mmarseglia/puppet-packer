require 'spec_helper'

describe 'packer' do
	context 'with default parameters on Linux 64-bit' do
	let(:facts) { {
		:architecture => 'x86_64',
		:kernel => 'Linux',
		:packer_version => '1.0.0',
	} }

	# required for module archive
	let(:environment) { 'production' }

	it { should compile }
	it { should contain_class('packer') }

	it do
	  is_expected.to contain_archive('/tmp/packer_1.0.0_linux_amd64.zip').with({
	    'source' => 'https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip',
	  })
	end
	end
end
