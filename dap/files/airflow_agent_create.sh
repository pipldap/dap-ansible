#!/bin/bash

export http_proxy=http://proxy.pipl.pro:3128
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export dns_proxy=$http_proxy
export rsync_proxy=$http_proxy

cd /opt/airflow/airflow_bin/


STAT=
eval "$(ssh-agent -s)"
STAT=$STAT$?
#ssh-add ~/.ssh/dap_ssh
ssh-add ~/.ssh/git_ssh
STAT=$STAT$?

git clone git@github.com:piplcom/dap-automations.git dags
STAT=$STAT$?

cd dags
STAT=$STAT$?
git pull
STAT=$STAT$?
cd ..
STAT=$STAT$?

cp -f /opt/airflow/airflow_bin/dags/airflow.cfg /opt/airflow/airflow_bin/
STAT=$STAT$?

cp -f /opt/airflow/airflow_bin/dags/celery_config.py /opt/airflow/airflow_bin/
STAT=$STAT$?

echo $STAT
exit $STAT













STAT=$STAT$?
pip install git+ssh://git@github.com/piplcom/address_cleanup.git@development
STAT=$STAT$?
pip install git+ssh://git@github.com/piplcom/pypipl.git
STAT=$STAT$?

#pip install cassandra-driver==3.10 --install-option="--no-cython"
pip install cassandra-driver==3.10
STAT=$STAT$?

cd venv_merge
STAT=$STAT$?
wget https://pypi.python.org/packages/source/d/distribute/distribute-0.6.14.tar.gz
STAT=$STAT$?
tar -xzf distribute-0.6.14.tar.gz
STAT=$STAT$?
cd distribute-0.6.14
STAT=$STAT$?
#python distribute-0.6.14/setup.py install
python setup.py install
STAT=$STAT$?


git clone git@github.com:piplcom/data-acquisition.git
STAT=$STAT$?

export LIBRARY_PATH=/usr/local/lib/
STAT=$STAT$?
# pip install -r data-acquisition/requirements.txt

REQ="
MySQL-python==1.2.3
SQLAlchemy==0.7.9
anyjson==0.3.3
argparse==1.2.1
cassandra-driver==3.10
celery==3.1.5
celery-with-redis==3.0
chardet
elements
lockfile==0.9.1
lxml
path.py==3.1
phonenumbers==8.8.6
pycassa==1.10.0
pycrypto==2.4.1
python-dateutil==1.5
pytz==2013.8
redis==2.7.6
simplejson==3.2.0
validate_email
regex
PyICU==1.8
"


for I in $REQ
do
    echo installing: $I
    pip install $I
    STAT=$STAT$?
done


echo Status $STAT
exit $STAT
