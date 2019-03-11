require 'spec_helper'

describe 'packer' do
  on_supported_os.each do |os, facts|
    context "with default parameters on #{os}" do
      let(:facts) { facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('packer') }
      it { is_expected.to contain_archive('/tmp/packer_1.1.2_linux_amd64.zip').with('source' => 'https://releases.hashicorp.com/packer/1.1.2/packer_1.1.2_linux_amd64.zip') }
    end
  end
end
