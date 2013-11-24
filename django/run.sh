#!/bin/bash
APP_DIR=${APP_DIR:-/app}

cd $APP_DIR
# install requirements
find . -name "requirements.txt" -exec pip install -r {} \;
# sync db
python manage.py syncdb --noinput
# check for south and migrate if needed
SOUTH_ENABLED=`pip freeze | grep South`
if [ ! -z "$SOUTH_ENABLED" ] ; then
    python manage.py migrate
fi
# find app module
APP_MODULE_PATH=`find . -name "wsgi.py" | head -1`
APP_MODULE=`basename $APP_MODULE_PATH .py`
# find static dirs
STATIC_DIR=`find . -name "static" | head -1`

# uwsgi
CMD="uwsgi --http-socket 0.0.0.0:8000 -p 4 -b 32768 -T --master --max-requests 5000 --static-map /static=/usr/local/lib/python2.7/dist-packages/django/contrib/admin/static --module $APP_MODULE:application --python-path=/app"
if [ ! -z "$STATIC_DIR" ] ; then
    CMD="$CMD --static-map /static=${STATIC_DIR}"
fi
echo $CMD
$CMD
