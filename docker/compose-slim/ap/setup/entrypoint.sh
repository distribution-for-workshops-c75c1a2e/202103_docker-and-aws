#!/bin/bash -x
# Initial settings and gunicorn server activation.

if ! [ -e /tmp/container-init.log ]; then
  echo "You started this container for the 1st time @ $(date)" > /tmp/container-init.log

  # Create a django project directory.
  django-admin startproject ${DJANGO_PJ} .

  # Generate django's secret key.
  python /setup/generate_secret_key.py

  # Edit settings.py
  sed -i -e '/^SECRET_KEY/d' \
      -i -e  '/^ALLOWED_HOSTS/d' \
      -i -e  '/^LANGUAGE_CODE/d' \
      -i -e  '/^TIME_ZONE/d' \
      ${DJANGO_PJ}/settings.py

  cat <<\EOF >> ${DJANGO_PJ}/settings.py

LANGUAGE_CODE = 'ja'
TIME_ZONE = 'Asia/Tokyo'

import configparser
import os

ALLOWED_HOSTS = ['127.0.0.1', 'localhost']

config = configparser.ConfigParser()
config.optionxform = str
config.read(f'{BASE_DIR}/config.ini', encoding='utf-8')
SECRET_KEY = config['AP']['SECRET_KEY']
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.environ['DJANGO_PJ'],
        'USER': os.environ['DB_USER'],
        'PASSWORD': os.environ['POSTGRES_PASSWORD'],
        'HOST': os.environ['DB_CONTAINER'],
        'PORT': os.environ['DB_PORT']
    }
}
EOF

  while :; do
    python manage.py migrate && break
  done
fi


gunicorn ${DJANGO_PJ}.wsgi \
  --access-logfile /var/log/gunicorn/access.log \
  --error-logfile /var/log/gunicorn/error.log \
  --log-level debug \
  -b 0:${AP_PORT} --reload
