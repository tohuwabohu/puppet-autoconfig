require 'spec_helper'

describe 'autoconfig' do
  let(:title) { 'autoconfig' }
  let(:facts) { {:concat_basedir => '/tmp'} }

  describe 'by default' do
    let(:params) { {} }

    it { should contain_file('/etc/autoconfig') }
    it { should contain_concat('/etc/autoconfig/apache.conf') }
    it { should contain_concat('/etc/autoconfig/nginx.conf') }
  end

  describe 'uses custom config_dir' do
    let(:params) { {:config_dir => '/different/path'} }

    it { should contain_file('/different/path') }
    it { should contain_concat('/different/path/apache.conf') }
    it { should contain_concat('/different/path/nginx.conf') }
  end
end
