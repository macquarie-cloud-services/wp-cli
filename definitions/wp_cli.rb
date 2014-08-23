#
# Cookbook Name:: wp-cli
# Definition:: wp_cli
#

::Chef::Recipe.send(:include, WpCli::Helpers)

define :wp_cli,
  :args => {},
  :cwd => nil,
  :user => nil do

  params[:command] ||= params[:name]
  params[:cwd] ||= node['wordpress']['dir']
  params[:user] ||= node['wordpress']['install']['user']

  include_recipe 'wp-cli'

  args_str = args_to_s(params[:args])

  execute "wp-cli #{params[:command]} #{args_str}" do
    command "#{node['wp-cli']['bin']} #{params[:command]}#{args_str}"
    cwd params[:cwd]
    user params[:user]
  end
end
