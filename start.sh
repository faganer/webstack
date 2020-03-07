#!/bin/bash
echo "==============================="
echo "=";
echo "= Start installing LAMP (Linux, Apache, PHP, MariaDB)."
echo "="
echo "==============================="
yum install wget yum-utils -y
mv /etc/yum.repos.d /etc/yum.repos.d.back
mkdir /etc/yum.repos.d
ver=`rpm -q centos-release|cut -d- -f3`
if [ $ver -eq 6 ];
then
  echo "= Install CentOS Base REPO."
  wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.githubusercontent.com/faganer/webstack/master/CentOS-6.repo
  echo "= Install Extra Packages for Enterprise Linux (EPEL)."
  yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
  echo "= Install Remi's RPM repository."
  yum install https://rpms.remirepo.net/enterprise/remi-release-6.rpm
  echo "= Install MariaDB repo."
  wget -O /etc/yum.repos.d/MariaDB.repo https://raw.githubusercontent.com/faganer/webstack/master/MariaDB-10.3-CentOS-6-x86_64.repo
  yum makecache
  yum-config-manager --enable remi remi-php73
  yum install php php-bcmath php-cli php-common php-dba php-devel php-embedded php-enchant php-pecl-mcrypt php-pecl-imagick php-pecl-libsodium php-fpm php-gd php-intl php-ldap php-mbstring php-mysql php-mysqlnd php-odbc php-pdo php-pear php-pecl-memcache php-pgsql php-process php-pspell php-recode php-snmp php-soap php-xml php-xmlrpc php-opcache mod_ssl sendmail unzip crontabs MariaDB-server MariaDB-client
  service httpd restart && service mysql restart
  mysql_secure_installation
fi
if [ $ver -eq 7 ];
then
  echo "= Install CentOS Base REPO."
  wget -O /etc/yum.repos.d/CentOS-Base.repo https://raw.githubusercontent.com/faganer/webstack/master/CentOS-7.repo
  echo "= Install Extra Packages for Enterprise Linux (EPEL)."
  yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  echo "= Install Remi's RPM repository."
  yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
  echo "= Install MariaDB repo."
  wget -O /etc/yum.repos.d/MariaDB.repo https://raw.githubusercontent.com/faganer/webstack/master/MariaDB-10.3-CentOS-7-x86_64.repo
  yum makecache
  yum-config-manager --enable remi remi-php73
  yum install php php-bcmath php-cli php-common php-dba php-devel php-embedded php-enchant php-pecl-mcrypt php-pecl-imagick php-pecl-libsodium php-fpm php-gd php-intl php-ldap php-mbstring php-mysql php-mysqlnd php-odbc php-pdo php-pear php-pecl-memcache php-pgsql php-process php-pspell php-recode php-snmp php-soap php-xml php-xmlrpc php-opcache mod_ssl sendmail unzip crontabs MariaDB-server MariaDB-client
  service httpd restart && service mysql restart
  mysql_secure_installation
fi