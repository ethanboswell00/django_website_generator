#!/bin/sh

WEBSITE_NAME=$1
PORT_NUM=$2
START_OR_NOT=$3

mkdir $WEBSITE_NAME
cd $WEBSITE_NAME

ENV_NAME="$WEBSITE_NAME"_env

virtualenv $ENV_NAME

source $ENV_NAME/bin/activate

pip install django
django-admin.py startproject $WEBSITE_NAME .

python manage.py migrate

mkdir static_storage
mkdir static_serve
mkdir templates

pwd
cp ../template_files/views.py $WEBSITE_NAME/views.py
cp ../template_files/urls.py $WEBSITE_NAME/urls.py
cp ../template_files/home.html templates/home.html

read -r -d '' APPENDING << EOM


STATIC_URL = '/static/'

STATICFILES_DIRS = [
    # Will not be served - long-term storage
    os.path.join(BASE_DIR, "static_storage")
]

STATIC_ROOT = os.path.join(BASE_DIR, "static_serve")
EOM

echo "$APPENDING" >> $WEBSITE_NAME/settings.py

sed -i "57s/.*/        'DIRS': [os.path.join(BASE_DIR, \"templates\")],/" $WEBSITE_NAME/settings.py

cd static_storage
mkdir static
cd static
mkdir css
mkdir js

cp ../../../bootstrap/bootstrap.min.css css
cp ../../../bootstrap/bootstrap-theme.min.css css
cp ../../../bootstrap/bootstrap.min.js js
cp ../../../bootstrap/jquery.min.js js

cd ../..
pwd

python manage.py collectstatic
python manage.py createsuperuser

echo "Your website is ready to run! Run by going to a command line, navigating to `pwd`, and typing 'python manage.py runserver 127.0.0.1:$PORT_NUM'. Thank you for using the website generator." > info.txt

if [[ "$START_OR_NOT" -eq "1" ]]; then
	python manage.py runserver 127.0.0.1:$PORT_NUM &
fi
