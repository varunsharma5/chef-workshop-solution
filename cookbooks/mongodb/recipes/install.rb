# Create a /etc/yum.repos.d/mongodb.repo file to hold the following configuration information for the MongoDB repository
directory '/etc/yum.repos.d'

template '/etc/yum.repos.d/mongodb.repo' do
  source 'mongodb.repo.erb'
end

package "mongodb-org" do
 action :install
 version '4.4.4'
end


service 'mongod' do
  action [:enable, :start]
end
