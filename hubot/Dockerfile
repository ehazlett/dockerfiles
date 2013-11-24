from ubuntu:12.04
maintainer evan hazlett <ejhazlett@gmail.com>
run apt-get update
run apt-get install -y python-dev wget make g++ libreadline-dev libncurses5-dev
run wget http://nodejs.org/dist/v0.10.22/node-v0.10.22.tar.gz -O /tmp/node.tar.gz
run (cd /tmp && tar zxf node.tar.gz && cd node-* && ./configure ; make install)
run npm install -g hubot coffee-script
