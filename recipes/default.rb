#
# Cookbook Name:: vhosts-hd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


(node[:vhost_hd][:vhosts]).each do |vhost|
    template "/etc/apache2/sites-available/#{vhost}" do
      source "vhost.conf.erb"
      mode 0440
      owner "root"
      group "root"
      variables({
         :vdomain => vhost
      })
    end
end

execute "service apache2 restart" do
  command "service apache2 restart"
end

