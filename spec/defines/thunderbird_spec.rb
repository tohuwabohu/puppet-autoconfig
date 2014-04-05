require 'spec_helper'

describe 'autoconfig::thunderbird' do
  let(:title) { 'example.com' }
  let(:facts) { {:concat_basedir => '/tmp'} }

  describe 'by default' do
    let(:params) { {} }

    it { should contain_file('/var/www/autoconfig.example.com/mail/config-v1.1.xml') }
    it { should contain_concat__fragment('autoconfig_example.com_apache').with(
        'target' => '/etc/autoconfig/apache.conf'
      )
    }
    it { should contain_concat__fragment('autoconfig_example.com_nginx').with(
        'target' => '/etc/autoconfig/nginx.conf'
      ) 
    }
  end

  describe 'with ensure absent' do
    let(:params) { {:ensure => 'absent'} }

    it { should contain_file('/var/www/autoconfig.example.com').with(
        'ensure' => 'absent',
        'force'  => true
      )
    }
    it { should contain_concat__fragment('autoconfig_example.com_apache').with_ensure('absent') }
    it { should contain_concat__fragment('autoconfig_example.com_nginx').with_ensure('absent') }
  end
end
