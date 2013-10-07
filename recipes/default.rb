#
# Cookbook Name:: locales
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['locales']['packages'].each do |pack|
  package pack
end

locales node['locales']['default']
