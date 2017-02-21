#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['rbenv']['package'].each do |package|
  package "#{package['name']}" do
    action :install
    name "#{package['name']}"
  end
end

# gitで取得(rbenv)
git "#{node['rbenv']['git']['rbenv']['repository']}" do 
  action :sync
  user "#{node['rbenv']['user']['name']}"
  group "#{node['rbenv']['user']['name']}"
  repository "#{node['rbenv']['git']['rbenv']['repository']}"
  reference "master"
  destination "/home/#{node['rbenv']['user']['name']}/#{node['rbenv']['git']['rbenv']['path']}"
end

# 環境変数の設定
node['rbenv']['env'].each do |env|
  bash "#{env['guard']}" do
    user "#{node['rbenv']['user']['name']}"
    code <<-EOC
      echo "#{env['path']}" >> "/home/#{node['rbenv']['user']['name']}/.bash_profile"
    EOC
    not_if "grep #{env['guard']} /home/#{node['rbenv']['user']['name']}/.bash_profile"
  end
end

# ディレクトリの作成
node['rbenv']['ruby-build']['directory'].each do |dir| 
  directory "#{dir['path']}" do
    action :create
    owner "#{node['rbenv']['user']['name']}"
    group "#{node['rbenv']['user']['name']}"
  end
end
  
# gitで取得(ruby-build)
git "#{node['rbenv']['git']['ruby-build']['repository']}" do 
  action :sync
  user "#{node['rbenv']['user']['name']}"
  group "#{node['rbenv']['user']['name']}"
  repository "#{node['rbenv']['git']['ruby-build']['repository']}"
  reference "master"
  destination "/home/#{node['rbenv']['user']['name']}/#{node['rbenv']['git']['ruby-build']['path']}"
end

# rubyのビルド
bash "rbenv install" do
  user "root"
  code <<-EOC
    su "#{node['rbenv']['user']['name']}" -l -c "rbenv install #{node['rbenv']['version']}"
    su "#{node['rbenv']['user']['name']}" -l -c "rbenv global #{node['rbenv']['version']}"
  EOC
  not_if {File.exists?("/home/#{node['rbenv']['user']['name']}/.rbenv/versions/#{node['rbenv']['version']}")}
end
