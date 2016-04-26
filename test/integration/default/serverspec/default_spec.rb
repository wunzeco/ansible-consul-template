require 'spec_helper'

consul_template_user  = 'consul-template'
consul_template_group = consul_template_user

consul_template_bin_dir  = '/usr/local/bin'
consul_template_log_dir  = '/var/log/consul-template'
consul_template_work_dir = '/opt/consul-template'
consul_template_conf_dir = "#{consul_template_work_dir}/conf"


describe group(consul_template_group) do
  it { should exist }
end

describe user(consul_template_user) do
  it { should exist }
  it { should belong_to_group consul_template_group }
end

%W( 
  #{consul_template_log_dir}
  #{consul_template_work_dir}
  #{consul_template_conf_dir}
).each do |dir|
  describe file(dir) do
    it { should be_directory }
    it { should be_mode 755 }
    it { should be_owned_by consul_template_user }
  end
end

describe file(consul_template_bin_dir) do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
end

describe file("#{consul_template_bin_dir}/consul-template") do
  it { should be_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
end

describe file('/etc/init.d/consul-template') do
  it { should be_file }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
end

describe file("#{consul_template_conf_dir}/defaults.conf") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by consul_template_user }
end

describe file("#{consul_template_conf_dir}/template-jenkins-8080-include.conf") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by consul_template_user }
end

describe file("#{consul_template_conf_dir}/template-jenkins-8080-upstream.conf") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by consul_template_user }
end

describe service('consul-template') do
  it { should be_running }
end
