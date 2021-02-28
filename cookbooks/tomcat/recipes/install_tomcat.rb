group 'tomcat'

directory '/opt/tomcat'

user 'tomcat' do
  gid 'tomcat'
  home '/opt/tomcat'
  shell '/bin/nologin'
  action :create
end

tmp_tomcat_file = Chef::Config[:file_cache_path] + '/tomcat.tar.gz'

remote_file tmp_tomcat_file do
  # source 'http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.20/bin/apache-tomcat-8.5.20.tar.gz' => this is not working ...404
  source 'https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.63/bin/apache-tomcat-8.5.63.tar.gz' # use attiribute to get the tomcat version
  action :create
end

# archive_file '/tmp/tomcat.tar.gz' do
#   destination '/opt/tomcat'
#   overwrite true
#   action :extract
# end

execute 'extract_tomcat' do
  command 'sudo tar xvf tomcat.tar.gz -C /opt/tomcat --strip-components=1'
  cwd '/tmp'
end

execute 'update_permission' do
  cwd '/opt/tomcat'
  command 'sudo chgrp -R tomcat /opt/tomcat'
  command 'sudo chmod -R g+r conf'
  command 'sudo chmod g+x conf'
  command 'sudo chown -R tomcat webapps/ work/ temp/ logs/ bin/ lib/ conf/'
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

systemd_unit 'daemon-reload' do
  action :reload
end

service 'tomcat' do
  action [:enable, :start]
end
