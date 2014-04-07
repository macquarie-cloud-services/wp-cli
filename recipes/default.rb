#
# Cookbook Name:: wp-cli
# Recipe:: default
#
# Author: Rubem Nakamura
# License: MIT
#

directory node['wp-cli']['dir'] do
  recursive true
end

remote_file "#{node['wp-cli']['dir']}/installer.sh" do
  source 'http://wp-cli.org/installer.sh'
  mode 0755
  action :create_if_missing
end

node['wp-cli']['bin'] = ::File.join(node['wp-cli']['dir'], 'bin', 'wp')

bash 'install wp-cli' do
  code './installer.sh'
  cwd node['wp-cli']['dir']
  environment 'INSTALL_DIR' => node['wp-cli']['dir'],
              'VERSION'     => node['wp-cli']['version']
  creates node['wp-cli']['bin']
end

link node['wp-cli']['link'] do
  to node['wp-cli']['bin']
end if node['wp']['link']
