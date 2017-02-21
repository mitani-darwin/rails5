default['rbenv']['version'] = "2.2.3"
default['rbenv']['user']['name'] = "vagrant"
default['rbenv']['user']['passwd'] = '$1$LRUCUVXQ$VolBjJ5dUy9QoAsfTIfzE0'

default['rbenv']['package'] = [
  {name: 'git'},
  {name: 'gcc'},
  {name: 'openssl-devel'},
  {name: 'readline-devel'},
  {name: 'zlib-devel'},
  {name: 'rsync'},
  {name: 'bzip2'}
]

default['rbenv']['git']['rbenv']['repository'] = "https://github.com/sstephenson/rbenv.git"
default['rbenv']['git']['rbenv']['path'] = ".rbenv"


default['rbenv']['env'] = [
  {path: 'export PATH=~/.rbenv/bin:\$PATH', guard: "rbenv"},
  {path: 'eval \\"\\$(rbenv init -)\\"', guard: "init"},
]

default['rbenv']['git']['ruby-build']['repository'] = "https://github.com/sstephenson/ruby-build.git"
default['rbenv']['git']['ruby-build']['path'] = ".rbenv/plugins/ruby-build"

default['rbenv']['ruby-build']['directory'] = [
  {path: "/home/#{node['rbenv']['user']['name']}/.rbenv/plugins/"},
  {path: "/home/#{node['rbenv']['user']['name']}/.rbenv/plugins/ruby-build"},
]
