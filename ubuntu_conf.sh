aptlist=(
    'cron'
    'ufw'
    'landscape-common'
    'update-notifier-common'
    'python2.7'
    'python-dev'
    'python-pip'
    'apache2'
    'lynx'
    'aptitude'
    'libapache2-mod-wsgi'
    'mysql-server'
    'libmysqlclient-dev'
    'python-mysql.connector'
    'python-mysqldb'
    'letsencrypt'
    'mailutils'
    'tree'
    'python-scipy'
    'python-numpy'
    'python-pandas'
    'postfix mailutils libsasl2-2 ac-certificates libsasl2-modules'
    )

piplist=(
    'mysql'
    'markdown'
    'lxml'
    'pygments'
    'pyzmq'
    'openpyxl'
    'xlrd'
    'xlwt'
    'xlutils'
    'xlsxwriter'
    # django
    'django==1.8'
    'django-admin-bootstrapped'
    'django-debug-toolbar'
    'django-extensions'
    'django-htmlmin'
    'django-letsencrypt'
    'django-passwords'
    'django-subdomains'
    # 'django-webtest'
    'coverage'
    'pymc'
    'scipy'
    'numpy'
    'pandas'
    'pandas-datareader'
    'matplotlib'
    )

custom=(
    'ipython'
    'ipython-notebook'
    )

if [[ $OSTYPE == linux* ]]; then
    for item in ${aptlist[@]}; do
       echo "apt-get install ${item}"
        apt-get install ${item}
    done
fi

pip install --upgrade pip

for item in ${piplist[@]}; do
    echo "pip install ${item}"
    pip install ${item}
done

# mysql
# mysql_install_db -- deprecated
# mysqld --initialize
# mysql_secure_installation
# sleep 10
# mysqladmin -u root -p status

if [[ $OSTYPE == linux* ]]; then
    for item in ${custom[@]}; do
        echo "apt-get install ${item}"
        apt-get -y install ${item}
    done
    if [ ! -f $HOME/.config/pip/pip.conf ]; then
        mkdir -p $HOME/.config/pip
    fi
    # cat > $HOME/.config/pip/pip.conf
    # [list]
    # format = columns
    # 
elif [[ $OSTYPE == darwin* ]]; then
    for item in ${custom[@]}; do
        echo "pip install ${item}"
        pip install ${item}
    done
fi


# pymc
#
echo
echo "Installing pymc"
if [[ $OSTYPE == linux* ]]; then
    apt-get install gfortran
    apt-get install liblapack-dev
elif [[ $OSTYPE == darwin* ]]; then
    brew install gfortran
fi
pip install pymc

# Google PageSpeed
if [[ $OSTYPE == linux* ]]; then
  cd /tmp
  wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
  dpkg -i /tmp/mod-pagespeed-*.deb
  apt-get -f install
  rm /tmp/mod-pagespeed-stable_current_amd64.deb
  cd
fi

# ufw
if [[ $OSTYPE == linux* ]]; then
  ufw status
  ufw allow OpenSSH
  ufw allow http 
  ufw allow https
  ufw deny 25
  ufw enable
  ufw status
fi

