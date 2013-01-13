#
# Cookbook Name:: locales
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/default/locale" do
  source "locale.erb"
  owner "root"
  group "root"
  mode 00755
end