require 'spec_helper'

consul_template_bin_dir  = '/usr/local/bin'
consul_template_log_dir  = '/var/log/consul-template'
consul_template_work_dir = '/opt/consul-template'
consul_template_conf_dir = "#{consul_template_work_dir}/conf"


%W( 
  #{consul_template_bin_dir}
  #{consul_template_log_dir}
  #{consul_template_work_dir}
  #{consul_template_conf_dir}
).each do |dir|
  describe file(dir) do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
  end
end

describe file("#{consul_template_bin_dir}/consul-template") do
  it { should be_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
end

if os[:family] =~ /ubuntu|debian/
  describe file('/etc/init.d/consul-template') do
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
  end
end

if os[:family] =~ /centos|redhat/
  describe file('/usr/lib/systemd/system/consul-template.service') do
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
  end
end

describe file("#{consul_template_conf_dir}/defaults.conf") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end

describe file("#{consul_template_conf_dir}/template-jenkins-8080-include.conf") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end

describe file("#{consul_template_conf_dir}/template-jenkins-8080-upstream.conf") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end

describe file('/etc/logrotate.d/consul-template') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
end

describe service('consul-template') do
  it { should be_running }
end
