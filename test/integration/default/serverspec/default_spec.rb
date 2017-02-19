require 'serverspec'
set :backend, :exec
describe 'fanatics-motd' do
  describe file '/etc/motd' do
    it { should be_file }
    its(:content) { should match 'ALERT' }
  end
end
