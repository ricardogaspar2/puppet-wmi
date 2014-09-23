require 'spec_helper'
describe 'wmi' do

  context 'with defaults for all parameters' do
    it { should contain_class('wmi') }
  end
end
