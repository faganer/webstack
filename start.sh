#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 1. Confirm system and user permissions.
echo "==============================="
echo "="
echo "= Start installing LAMP (Linux, Apache, PHP, MariaDB)."
echo "="
echo "==============================="
echo ""
echo "= Make sure the system is CentOS 6/7/8 and the permissions are root. Do you want to start the installation?"
select confirm in "yes" "no";do
  break;
done

# 2. System and user rights are correct.
if [ $confirm == "yes" ]; then

  echo "= Please choose to install Apache or nginx?"
  select type in "Apache" "nginx";do
    break;
  done

  # 2.5 The choice is Apache or nginx.
  if [ $type = "Apache" ] || [ $type = "nginx" ]; then

    # 2.5.1 Both Apache and nginx are executed.

    # Remove epil, remi.
    yum remove epel* remi* -y

    # Install wget, yum-utils.
    yum install wget yum-utils -y

    # Backup repos.
    DATE=`date +%F | sed 's/-//g'``date +%T | sed 's/://g'`
    mv /etc/yum.repos.d /etc/yum.repos.d.back.$DATE
    mkdir /etc/yum.repos.d

    # Determine the system version.
    ver=`rpm -q centos-release|cut -d- -f3`

    # CentOS repo.
    echo "= Install CentOS Base REPO."
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://cdn.jsdelivr.net/gh/faganer/webstack@master/CentOS-$ver.repo

    # EPEL.
    echo "= Install Extra Packages for Enterprise Linux (EPEL)."
    yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-$ver.noarch.rpm -y

    # remi.
    echo "= Install Remi's RPM repository."
    yum install https://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/remi-release-$ver.rpm -y

    # CentOS 6
    if [ $ver -eq 6 ]; then

      # MariaDB
      echo "= Please select the MariaDB version: "
      echo "";
      MariaDBVerOptions="5.5 10.1 10.2 10.3"
      select MariaDBVer in $MariaDBVerOptions;do
      break;
      done
      echo "= Install MariaDB "$MariaDBVer "repo."
      echo "";
      wget -O /etc/yum.repos.d/MariaDB.repo http://cdn.jsdelivr.net/gh/faganer/webstack@master/CentOS-$ver-x86_64/MariaDB-$MariaDBVer.repo

    # CentOS 7
    elif [ $ver -eq 7 ]; then

      # MariaDB
      echo "= Please select the MariaDB version: "
      echo "";
      MariaDBVerOptions="5.5 10.1 10.2 10.3 10.4"
      select MariaDBVer in $MariaDBVerOptions;do
      break
      done
      echo "= Install MariaDB "$MariaDBVer "repo."
      echo "";
      wget -O /etc/yum.repos.d/MariaDB.repo http://cdn.jsdelivr.net/gh/faganer/webstack@master/CentOS-$ver-x86_64/MariaDB-$MariaDBVer.repo

    # CentOS 8
    elif [ $ver -eq 8 ]; then

      # MariaDB
      echo "= Please select the MariaDB version: "
      echo "";
      MariaDBVerOptions="10.3 10.4"
      select MariaDBVer in $MariaDBVerOptions;do
      break
      done
      echo "= Install MariaDB "$MariaDBVer "repo."
      echo "";
      wget -O /etc/yum.repos.d/MariaDB.repo http://cdn.jsdelivr.net/gh/faganer/webstack@master/CentOS-$ver-x86_64/MariaDB-$MariaDBVer.repo

    fi

    # 2.5.2 Choose Apache.
    if [ $type = "Apache" ]; then

      # PHP extension
      phpExtApache="php php-bcmath php-cli php-common php-dba php-devel php-embedded php-enchant php-gd php-imap php-intl php-json php-ldap php-mbstring php-mysqlnd php-odbc php-opcache php-pdo php-pecl-mcrypt php-pecl-imagick php-pgsql php-process php-pspell php-recode php-snmp php-soap php-tidy php-xml php-xmlrpc"

      # lamp
      yum makecache
      yum-config-manager --enable remi remi-php73
      yum install $phpExtApache ImageMagick mod_ssl sendmail unzip crontabs MariaDB-server MariaDB-client -y --skip-broken

      # Restart httpd and mysql.
      service httpd restart && service mysql restart

      # Config MySQL.
      mysql_secure_installation
    
    # 2.5.3 Choose nginx.
    elif [ $type = "nginx" ]; then
      
      # PHP extension
      phpExtNginx="php php-bcmath php-cli php-common php-dba php-devel php-embedded php-enchant php-fpm php-gd php-imap php-intl php-json php-ldap php-mbstring php-mysqlnd php-odbc php-opcache php-pdo php-pecl-mcrypt php-pecl-imagick php-pgsql php-process php-pspell php-recode php-snmp php-soap php-tidy php-xml php-xmlrpc"

      # nginx.
      wget -O /etc/yum.repos.d/nginx.repo http://cdn.jsdelivr.net/gh/faganer/webstack@master/nginx.repo

      # lnmp
      yum makecache
      yum-config-manager --enable remi remi-php73
      echo "= Please choose nginx stable or mainline packages: "
      select nginx in "stable" "mainline";do
        break;
      done
      if [ $nginx == "mainline" ]; then
        yum-config-manager --enable nginx-mainline
      fi
      yum install $phpExtNginx ImageMagick mod_ssl sendmail unzip crontabs MariaDB-server MariaDB-client nginx -y --skip-broken

      # Restart httpd and mysql.
      service httpd restart && service mysql restart

      # Config MySQL.
      mysql_secure_installation

    fi

  # 2.6 No choice of Apache or nginx.
  else
    
    # Restore repos.
    rm -rf /etc/yum.repos.d
    mv /etc/yum.repos.d.back.$DATE /etc/yum.repos.d
  fi

# 3. Exit system and user permission judgment.
else
  exit 0
fi