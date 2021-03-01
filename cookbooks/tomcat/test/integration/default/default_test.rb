# InSpec test for recipe tomcat::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end

# Tests for tomcat
describe package('java-1.8.0-openjdk.x86_64') do 
  it {should be_installed}
end

describe service('tomcat') do
    it {should be_running}
end

describe port(8080) do
  it { should be_listening }
end
