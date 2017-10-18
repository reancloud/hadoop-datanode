#
# Cookbook Name:: hadoop-datanode
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'hadoop::hadoop_hdfs_datanode'

package "default-jdk" do
  action :install
end

ruby_block  "set-env-java-home" do
  block do
    ENV["JAVA_HOME"] = '/usr/lib/jvm/java-7-openjdk-amd64'
    #ENV['PATH'] = "#{ENV['PATH']}:#{node['java']['path']}/bin"
  end
end

bash 'set-env-profile.d' do
  code <<-EOH
    echo -e "export JAVA_HOME=$JAVA_HOME" >> /etc/profile.d/jdk.sh
    echo -e "export PATH=$PATH" >> /etc/profile.d/jdk.sh
  EOH
end

ruby_block 'service-hadoop-hdfs-datanode-start-and-enable' do
  block do
    %w(enable start).each do |action|
      resources('service[hadoop-hdfs-datanode]').run_action(action.to_sym)
    end
  end
end


