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

  describe 'with custom config_dir' do
    let(:params) { {:config_dir => '/different/path'} }

    it { should contain_file('/different/path') }
    it { should contain_concat('/different/path/apache.conf') }
    it { should contain_concat('/different/path/nginx.conf') }
  end

  describe 'with custom apache_config_file' do
    let(:params) { {:apache_config_file => '/path/to/apache.conf'} }

    it { should contain_concat('/path/to/apache.conf') }
    it { should contain_concat('/etc/autoconfig/nginx.conf') }
  end

  describe 'with custom nginx_config_file' do
    let(:params) { {:nginx_config_file => '/path/to/nginx.conf'} }

    it { should contain_concat('/etc/autoconfig/apache.conf') }
    it { should contain_concat('/path/to/nginx.conf') }
  end
end
