from ubuntu:12.04
maintainer evan hazlett <ejhazlett@gmail.com>
run echo "deb http://us.archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list
run echo "deb-src http://us.archive.ubuntu.com/ubuntu precise main universe multiverse" >> /etc/apt/sources.list
run apt-get update
run DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
run apt-get install -y python-dev python-setuptools libxml2-dev libxslt-dev git-core build-essential python-flup python-pip python-virtualenv nginx supervisor libmysqlclient-dev libpq-dev
run apt-get build-dep -y python-lxml python-imaging
run pip install uwsgi
run mkdir /opt/treeio
run (cd /opt/treeio && git clone https://github.com/treeio/treeio.git)
run (cd /opt/treeio/treeio && virtualenv venv)
run (cd /opt/treeio/treeio && ./venv/bin/pip install Pillow)
run (cd /opt/treeio/treeio && ./venv/bin/pip install -r requirements.pip)
run (cd /opt/treeio/treeio && ./venv/bin/pip install MySQL-Python==1.2.3)
run (cd /opt/treeio/treeio && ./venv/bin/pip install psycopg2)
run (cd /opt/treeio/treeio && ./venv/bin/python related_fields_patch.py ./venv/lib/python2.7/site-packages/django)
add run.sh /usr/local/bin/run
expose 80
cmd ["/usr/local/bin/run"]

