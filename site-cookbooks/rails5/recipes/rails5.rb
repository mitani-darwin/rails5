#
# Cookbook Name:: rails
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# gemでインストールする
bash "gem install" do
  user "root"
  code <<-EOC
    su "#{node['rails']['user']['name']}" -l -c "rbenv exec gem install bundler"
    su "#{node['rails']['user']['name']}" -l -c "rbenv exec gem install rails #{node['rails']['version']}"
  EOC
end
