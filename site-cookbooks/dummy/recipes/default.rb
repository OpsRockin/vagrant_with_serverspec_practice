#
# Cookbook Name:: dummy
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


file '/tmp/date' do
  content Time.now.to_s
end
