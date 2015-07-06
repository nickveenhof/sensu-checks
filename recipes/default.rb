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

sensu_client node.name do
  address node["ipaddress"]
  subscriptions ["all"]
end

sensu_check "redis_process" do
  command "check-procs.rb -p redis-server -C 1"
  handlers ["default"]
  subscribers ["redis"]
  interval 30
  additional(:notification => "Redis is not running", :occurrences => 5)
end

include_recipe "sensu::client_service"

if platform?("ubuntu")
  package "net-tools"
end