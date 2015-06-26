require 'spec_helper'

describe 'pam' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "pam class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('pam::params') }
          it { is_expected.to contain_class('pam::install').that_comes_before('pam::config') }
          it { is_expected.to contain_class('pam::config') }
          it { is_expected.to contain_class('pam::service').that_subscribes_to('pam::config') }

          it { is_expected.to contain_service('pam') }
          it { is_expected.to contain_package('pam').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'pam class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('pam') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
