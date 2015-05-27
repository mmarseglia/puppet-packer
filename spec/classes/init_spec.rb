require 'spec_helper'
describe 'packer' do

  context 'with defaults for all parameters' do
    it { should contain_class('packer') }
  end
end
