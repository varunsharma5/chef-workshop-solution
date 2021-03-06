# Overview

Cook for installing and configuring mongodb

## Instructions to run the cookbook

#### Prerequisites
- The latest version of Chef Workstation.
- The virtualization software VirtualBox and Vagrant.

#### Clone git the repository using following command:
git clone  https://github.com/varunsharma5/chef-workshop-solution.git

#### Running MongoDB Cookbook
##### On Local machine using Test Kitchen via Vagrant and Virtual Box
- Goto directory: chef-workshop-solution/cookbooks/mongodb
- run command: <code>kitchen converge centos</code> => this will start an centos VM and run the recipe to it treating it as a target machine
- run command to run inspec test cases: <code>kitchen verify centos</code>
- run command to login to the created VM: <code>kitchen login centos</code>
- on the looged-in centos session, run command to check the proper installtion of mongdo db: <code>mongodb</code> => this would open mongodb console
- type <code>exit</code> to come out from logged-in session
- run command to stop running VM: <code>kitchen destory centos</code>

##### On target RHEL based instance using chef-client
- Goto directory: chef-workshop-solution/cookbooks/mongodb
- run command: <code>sudo chef-client --local-mode -r mongodb::install</code> => this will install and configure mongdo db on the instance
- run command to check if mongodb is installed and configured properly: <code>mongodb</code> => this would open mongodb console
