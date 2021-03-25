#
# Cookbook:: tomcat
# Recipe:: install_tomcat
#


# Create a user for tomcat
group 'tomcat'

directory '/opt/tomcat'

user 'tomcat' do
  gid 'tomcat'
  home '/opt/tomcat'
  shell '/bin/nologin'
  action :create
end

# Download the Tomcat Binary

tmp_tomcat_file = '/tmp/tomcat.tar.gz'

remote_file tmp_tomcat_file do
  # source 'http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz' => this is not working ...404
  source 'https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.64/bin/apache-tomcat-8.5.64.tar.gz'
  action :create
end

# Extract the Tomcat Binary
execute 'extract_tomcat' do
  command 'sudo tar xvf tomcat.tar.gz -C /opt/tomcat --strip-components=1'
  cwd '/tmp'
end

# Update the Permissions
execute 'update_permission' do
  cwd '/opt/tomcat'
  command 'sudo chgrp -R tomcat /opt/tomcat'
  command 'sudo chmod -R g+r conf'
  command 'sudo chmod g+x conf'
  command 'sudo chown -R tomcat webapps/ work/ temp/ logs/ bin/ lib/ conf/'
end

# Install the Systemd Unit File
template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

# Reload Systemd to load the Tomcat Unit file
systemd_unit 'daemon-reload' do
  action :reload
end

# Ensure tomcat is started and enabled
service 'tomcat' do
  action [:enable, :start]
end
