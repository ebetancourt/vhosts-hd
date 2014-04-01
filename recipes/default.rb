#
# Cookbook Name:: vhosts-hd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


(node[:vhost_hd][:vhosts]).each do |vhost|

    directory "/var/www/#{vhost}/releases/test" do
      owner 'www-data'
      group 'www-data'
      action :create
      recursive true
    end

    template "/var/www/#{vhost}/releases/test/index.html" do
      source "index.erb"
      mode 0755
      owner 'www-data'
      group 'www-data'
      variables({
         :vdomain => vhost
      })
    end

    link "/var/www/#{vhost}/current" do
      to "/var/www/#{vhost}/releases/test"
    end

    template "/etc/apache2/sites-available/#{vhost}" do
      source "vhost.conf.erb"
      mode 0440
      owner "root"
      group "root"
      variables({
         :vdomain => vhost
      })
    end

    link "/etc/apache2/sites-enabled/#{vhost}" do
      to "/etc/apache2/sites-available/#{vhost}"
    end
end

execute "service apache2 restart" do
  command "service apache2 restart"
end

