require 'spec_helper'

describe 'autoconfig::thunderbird' do
  let(:title) { 'example.com' }
  let(:facts) { {:concat_basedir => '/tmp'} }

  describe 'by default' do
    let(:params) { {} }

    it { should contain_file('/var/www/autoconfig/autoconfig.example.com/mail/config-v1.1.xml') }
  end

  describe 'with ensure absent' do
    let(:params) { {:ensure => 'absent'} }

    it { should contain_file('/var/www/autoconfig/autoconfig.example.com').with(
        'ensure' => 'absent',
        'force'  => true
      )
    }
  end
end
