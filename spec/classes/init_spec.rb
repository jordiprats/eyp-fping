
require 'spec_helper'

describe 'fping' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "fping class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_service('fping') }
          it { is_expected.to contain_package('fping').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'fping class without any parameters' do
      let(:facts) do
        {
          :osfamily        => 'SOFriki',
          :operatingsystem => 'SOFregit',
        }
      end

      it {
        expect { should raise_error(Puppet::Error) }
      }
    end
  end
end
