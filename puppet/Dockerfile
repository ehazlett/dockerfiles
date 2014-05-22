from stackbrew/ubuntu:14.04
maintainer Evan Hazlett <ejhazlett@gmail.com>
env DEBIAN_FRONTEND noninteractive
env RUNLEVEL 1
run apt-get update
run apt-get install -y ruby
run gem install --no-ri --no-rdoc puppet
cmd ["/bin/bash"]
