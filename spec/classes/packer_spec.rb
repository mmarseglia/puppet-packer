require 'spec_helper'

describe 'packer' do
				let(:facts) { {:architecture => 'x86_64', :kernel => 'Linux'} }
				let(:environment) { 'production' }

				it { should compile }
end
