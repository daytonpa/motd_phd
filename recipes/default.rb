#
# Cookbook Name:: phd_motd
# Recipe:: default
# Author:: Patrick Dayton  daytonpa@gmail.com
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#

template '/etc/motd' do
  source 'motd.erb'
  owner node['motd_phd']['user']
  group node['motd_phd']['group']
  mode '0644'
  manage_symlink_source true
end
