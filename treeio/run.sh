#!/bin/bash
APP_ROOT=/opt/treeio
APP_DIR=$APP_ROOT/treeio
LOG_DIR=/var/log/treeio
DB_HOST=${DB_HOST:-}
DB_PORT=${DB_PORT:-}
DB_USER=${DB_USER:-}
DB_PASS=${DB_PASS:-}
DB_ENGINE=${DB_ENGINE:-sqlite3}
DB_NAME=${DB_NAME:-treeio.db}
SMTP_HOST=${SMTP_HOST:-}
SMTP_PORT=${SMTP_PORT:-}
SMTP_USER=${SMTP_USER:-}
SMTP_PASS=${SMTP_PASS:-}
SMTP_USE_TLS=${SMTP_USE_TLS:-}
SMTP_FROM_ADDRESS=${SMTP_FROM:-}
SKIP_LOAD_DATA=${SKIP_DATA_LOAD:-}
SUPERVISOR_CONF=/opt/supervisor.conf

mkdir -p $LOG_DIR

# generate db config
cat << EOF > $APP_DIR/core/db/dbsettings.json
{
    "default": {
        "ENGINE": "django.db.backends.$DB_ENGINE",
        "NAME": "$DB_NAME",
        "USER": "$DB_USER",
        "PASSWORD": "$DB_PASS",
        "HOST": "$DB_HOST",
        "PORT": "$DB_PORT"
    }
}
EOF

# smtp settings
if [ ! -z "${SMTP_HOST}" ] ; then
    cat << EOF >> $APP_DIR/settings.py
EMAIL_HOST = '${SMTP_HOST}'
EMAIL_PORT = ${SMTP_PORT}
EMAIL_HOST_USER = '${SMTP_USER}'
EMAIL_HOST_PASSWORD = '${SMTP_PASS}'
EMAIL_FROM = '${SMTP_FROM_ADDRESS}'
EOF
fi
if [ ! -z "${SMTP_USE_TLS}" ] ; then
    cat << EOF >> $APP_DIR/settings.py
EMAIL_USE_TLS = True 
EOF
fi

# wsgi module
cat << EOF > $APP_DIR/wsgi.py
import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "treeio.settings")

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
EOF

# generate uwsgi config
cat << EOF >> $SUPERVISOR_CONF
[supervisord]
nodaemon=false

[unix_http_server]
file=/var/run//supervisor.sock
chmod=0700

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run//supervisor.sock

[program:app]
priority=10
directory=$APP_DIR
command=/usr/local/bin/uwsgi
    --http-socket 0.0.0.0:8000
    -p 4
    -b 32768
    -T
    --master
    --max-requests 5000
    -H $APP_DIR/venv
    --pp $APP_ROOT
    --pp $APP_DIR
    --static-map /static=$APP_DIR/static
    --static-map /static=$APP_DIR/venv/lib/python2.7/site-packages/django/contrib/admin/static
    --module wsgi:application
user=root
autostart=true
autorestart=true
stopsignal=QUIT
stdout_logfile=$LOG_DIR/app.log
stderr_logfile=$LOG_DIR/app.err
EOF

cd $APP_DIR
# sync, migrate, and loaddata for db
./venv/bin/python manage.py syncdb --all --noinput
./venv/bin/python manage.py migrate --all --fake --noinput --no-initial-data
if [ ! -z "$SKIP_LOAD_DATA" ] ; then
    ./venv/bin/python manage.py loaddata data.json
fi

supervisord -c $SUPERVISOR_CONF -n
