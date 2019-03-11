require 'spec_helper'

describe 'packer' do
  context 'with default parameters on Linux 64-bit' do
    let(:facts) do
      {
        architecture: 'x86_64',
        kernel: 'Linux',
      }
    end

    # required for module archive
    let(:environment) { 'production' }

    it { is_expected.to compile }
    it { is_expected.to contain_class('packer') }
    it { is_expected.to contain_archive('/tmp/packer_1.1.2_linux_amd64.zip').with('source' => 'https://releases.hashicorp.com/packer/1.1.2/packer_1.1.2_linux_amd64.zip') }
  end
end
