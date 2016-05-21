require 'spec_helper'

describe 'autoconfig' do
  let(:title) { 'autoconfig' }
  let(:facts) { {:concat_basedir => '/tmp'} }

  describe 'by default' do
    let(:params) { {} }

    it { should contain_file('/var/www/autoconfig') }
    it { should contain_file('/var/www/autoconfig/.htaccess') }
  end

  describe 'with custom config_dir' do
    let(:params) { {:www_root => '/different/path'} }

    it { should contain_file('/different/path') }
    it { should contain_file('/different/path/.htaccess') }
  end

  describe 'with custom domain' do
    let(:params) { {:domains => [ 'example.com' ]} }

    it { should contain_autoconfig__thunderbird('example.com') }
  end
end
