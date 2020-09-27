#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 1. Confirm system and user permissions.
printf "
=====================================================================
=                                                                   =
=                          Web Stack                                =
=                                                                   =
=  This script should never be used in a production environment.    =
=  Start installing LAMP/LNMP (Linux, Apache/nginx, PHP, MariaDB).  =
=  QQ 309946202, E-mail xnfaganer@163.com                           =
=                                                                   =
=====================================================================
"

while true;do

  read -r -p "= Confirm that the system is CentOS 6/7/8 and the current user is root. Do you want to start installing Web Stack? [Y/n] " confirm
  case $confirm in
      [yY][eE][sS]|[yY])

        # Determine the system version.
        ver=`rpm -q centos-release|cut -d- -f3`

        if [ $ver -eq 6 ] || [ $ver -eq 7 ] || [ $ver -eq 8 ]; then

          # 2.0 Initialize the MySQL password.
          MySQLPasswd=`tr -cd '[:alnum:]' </dev/urandom | head -c 12`
          chmod 777 mysql_secure.sh

          # 2.1 Remove epil, remi.
          yum remove epel* remi* -y

          # 2.2 Install wget, yum-utils.
          yum install wget yum-utils -y

          # 2.3 Backup repos.
          DATE=`date +%F | sed 's/-//g'``date +%T | sed 's/://g'`
          mv /etc/yum.repos.d /etc/yum.repos.d.back.$DATE
          mkdir /etc/yum.repos.d

          # 2.4 CentOS repo.
          echo "= Install CentOS Base REPO."
          sleep 3s
          \cp -a CentOS-$ver.repo /etc/yum.repos.d/CentOS-Base.repo

          # 2.5 EPEL.
          echo "= Install Extra Packages for Enterprise Linux (EPEL)."
          sleep 3s
          yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-$ver.noarch.rpm -y

          # 2.6 remi.
          echo "= Install Remi's RPM repository."
          sleep 3s
          yum install https://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/remi-release-$ver.rpm -y

          # 2.7.1 CentOS 6
          if [ $ver -eq 6 ]; then

            # MariaDB
            echo "= Please select the MariaDB version: "
            MariaDBVerOptions="5.5 10.1 10.2 10.3"
            select MariaDBVer in $MariaDBVerOptions;do
            break;
            done
            echo "= Install MariaDB "$MariaDBVer "repo."
            \cp -a CentOS-$ver-x86_64/MariaDB-$MariaDBVer.repo /etc/yum.repos.d/MariaDB.repo

            # PHP
            echo "= Please select the PHP version: "
            PHPVerOptions="7.0 7.1 7.2 7.3"
            select PHPVer in $PHPVerOptions;do
            break;
            done
            if [ $PHPVer="7.0" ];then
              PHPVer="70"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.1" ];then
              PHPVer="71"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.2" ];then
              PHPVer="72"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.3" ];then
              PHPVer="73"
              yum-config-manager --enable remi remi-php$PHPVer
            else
              yum-config-manager --enable remi
            fi

          # 2.7.2 CentOS 7
          elif [ $ver -eq 7 ]; then

            # MariaDB
            echo "= Please select the MariaDB version: "
            MariaDBVerOptions="5.5 10.1 10.2 10.3 10.4 10.5"
            select MariaDBVer in $MariaDBVerOptions;do
            break
            done
            echo "= Install MariaDB "$MariaDBVer "repo."
            \cp -a CentOS-$ver-x86_64/MariaDB-$MariaDBVer.repo /etc/yum.repos.d/MariaDB.repo

            # PHP
            echo "= Please select the PHP version: "
            PHPVerOptions="7.0 7.1 7.2 7.3 7.4"
            select PHPVer in $PHPVerOptions;do
            break;
            done
            if [ $PHPVer="7.0" ];then
              PHPVer="70"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.1" ];then
              PHPVer="71"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.2" ];then
              PHPVer="72"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.3" ];then
              PHPVer="73"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.4" ];then
              PHPVer="74"
              yum-config-manager --enable remi remi-php$PHPVer
            else
              yum-config-manager --enable remi
            fi

          # 2.7.3 CentOS 8
          elif [ $ver -eq 8 ]; then

            # MariaDB
            echo "= Please select the MariaDB version: "
            MariaDBVerOptions="10.3 10.4"
            select MariaDBVer in $MariaDBVerOptions;do
            break
            done
            echo "= Install MariaDB "$MariaDBVer "repo."
            \cp -a CentOS-$ver-x86_64/MariaDB-$MariaDBVer.repo /etc/yum.repos.d/MariaDB.repo

            # PHP
            echo "= Please select the PHP version: "
            PHPVerOptions="7.2 7.3 7.4"
            select PHPVer in $PHPVerOptions;do
            break;
            done
            if [ $PHPVer="7.2" ];then
              PHPVer="72"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.3" ];then
              PHPVer="73"
              yum-config-manager --enable remi remi-php$PHPVer
            elif [ $PHPVer="7.4" ];then
              PHPVer="74"
              yum-config-manager --enable remi remi-php$PHPVer
            else
              yum-config-manager --enable remi
            fi
            
          fi

          # 2.8 Install Apache or nginx.
          echo "= Please choose to install Apache or nginx:"
          select type in "Apache" "nginx";do
            break;
          done

          # 2.8.1 The choice is Apache or nginx.
          if [ $type = "Apache" ] || [ $type = "nginx" ]; then

            # 1 Choose Apache.
            if [ $type = "Apache" ]; then

              # PHP extension
              phpExtApache="php php-bcmath php-cli php-common php-dba php-devel php-embedded php-enchant php-gd php-imap php-intl php-json php-ldap php-mbstring php-mysqlnd php-odbc php-opcache php-pdo php-mcrypt php-pecl-imagick php-pecl-zip php-pgsql php-process php-pspell php-recode php-snmp php-soap php-tidy php-xml php-xmlrpc"

              # lamp
              yum makecache
              yum install $phpExtApache ImageMagick mod_ssl sendmail unzip crontabs MariaDB-server MariaDB-client -y --skip-broken

              # Restart httpd and mysql.
              service httpd restart && service mysql restart

              # Config MySQL.
              #mysql_secure_installation
              ./mysql_secure.sh $MySQLPasswd
              echo "Successfully installed."
              echo "The MySQL initialization password is: $MySQLPasswd"

              # Tips for success
              echo "= LAMP install successfully."
              sleep 3s
              exit 0

            # 2 Choose nginx.
            elif [ $type = "nginx" ]; then
              
              # PHP extension
              phpExtNginx="php php-bcmath php-cli php-common php-dba php-devel php-embedded php-enchant php-fpm php-gd php-imap php-intl php-json php-ldap php-mbstring php-mysqlnd php-odbc php-opcache php-pdo php-mcrypt php-pecl-imagick php-pecl-zip php-pgsql php-process php-pspell php-recode php-snmp php-soap php-tidy php-xml php-xmlrpc"

              # nginx.
              \cp -a nginx.repo /etc/yum.repos.d/

              # lnmp
              yum makecache
              echo "= Please choose nginx stable or mainline packages(default is stable): "
              select nginx in "stable" "mainline";do
                break;
              done
              if [ $nginx == "mainline" ]; then
                yum-config-manager --enable nginx-mainline
              fi
              yum install $phpExtNginx ImageMagick mod_ssl sendmail unzip crontabs MariaDB-server MariaDB-client nginx -y --skip-broken
              yum remove httpd -y

              # Restart nginx and mysql.
              service nginx restart && service php-fpm restart && service mysql restart

              # Config MySQL.
              #mysql_secure_installation
              ./mysql_secure.sh $MySQLPasswd
              echo "Successfully installed."
              echo "The MySQL initialization password is: $MySQLPasswd"
              
              # Tips for success
              echo "= LAMP install successfully."
              sleep 3s
              exit 0

            fi

          # 2.8.2 No choice of Apache or nginx.
          else
            
            # Restore repos.
            rm -rf /etc/yum.repos.d
            mv /etc/yum.repos.d.back.$DATE /etc/yum.repos.d
          fi

        # System version does not match.
        else
          echo "= System version does not match. Must be CentOS 6/7/8."
          echo "Exited."
          exit 0
        fi
      ;;

      [nN][oO]|[nN])
        echo "Exited."
        exit 1
      ;;

      *)
      echo "Invalid input."
      ;;
  esac

done