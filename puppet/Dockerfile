from ubuntu:12.04
maintainer Evan Hazlett <ejhazlett@gmail.com>
run echo "deb http://us.archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list
run echo "deb-src http://us.archive.ubuntu.com/ubuntu precise main universe multiverse" >> /etc/apt/sources.list
run apt-get update
run DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
run apt-get install -y wget
run apt-get install -y sudo
run wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb -O /tmp/puppetlabs.deb
run dpkg -i /tmp/puppetlabs.deb
run apt-get update
run DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -y puppet-common
cmd ["/bin/bash"]
