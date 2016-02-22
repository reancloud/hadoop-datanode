###
# core-site.xml settings. Overridden...
###
default['hadoop-datanode']['namenodeIP'] = #{node['fqdn']}
override['hadoop']['core_site']['fs.defaultFS'] = "hdfs://#{node['hadoop-datanode']['namenodeIP']}"
