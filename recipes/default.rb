#
# Cookbook Name:: sensu-checks
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "logrotate"

include_recipe "sensu::default"

sensu_plugin "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/http/check-http.rb"
sensu_plugin "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/load-metrics.rb"
sensu_plugin "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/cpu-metrics.rb"
sensu_plugin "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/disk-metrics.rb"
sensu_plugin "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/interface-metrics.rb"
sensu_plugin "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/memory-metrics.rb"
sensu_plugin "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/uptime-metrics.py"

sensu_plugin "check-mem.sh" do
	source_directory "plugins"
end

sensu_plugin "check-socket.rb" do
	source_directory "plugins"
end

sensu_plugin "check-dns.rb" do
  source_directory "plugins"
end

sensu_plugin "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/handlers/notification/pagerduty.rb" do
  asset_directory File.join(node.sensu.directory, "handlers")
end

sensu_asset "https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/extensions/checks/system_profile.rb" do
  asset_directory File.join(node.sensu.directory, "extensions")
end

sensu_client node.name do
  address node["ipaddress"]
  subscriptions ["all"]
end

include_recipe "sensu::client_service"

if platform?("ubuntu")
  package "net-tools"
end
