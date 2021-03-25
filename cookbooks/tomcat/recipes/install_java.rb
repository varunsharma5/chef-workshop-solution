# Install OpenJDK 7 JDK

package 'java-1.7.0-openjdk' do
  action :install
end

# yum_package 'java-1.7.0-openjdk'

# Getting following error for java 1.7:
# [2021-03-01T07:13:13+00:00] FATAL: Chef::Exceptions::Package: dnf_package[java-1.7.0-openjdk-devel] (tomcat::install_java line 9) had an error: Chef::Exceptions::Package: No candidate version available for java-1.7.0-openjdk-devel
# Therefore using the default java package

# package 'java'
