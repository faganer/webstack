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
=  Start uninstalling LAMP/LNMP (Linux, Apache/nginx, PHP, MariaDB).  =
=  QQ 309946202, E-mail xnfaganer@163.com                           =
=                                                                   =
=====================================================================
"

# 2. Contact information.
contact="QQ 309946202, E-mail xnfaganer@163.com"

# 3. Determine which rpm packages are installed
if command -v nginx >/dev/null 2>&1; then 
  echo "= Uninstalling nginx."
  sleep 2s
  yum remove nginx nginx-* -y
fi
if command -v apachectl >/dev/null 2>&1; then 
  echo "= Uninstalling Apache."
  sleep 2s
  yum remove httpd httpd-* -y
fi
if command -v php >/dev/null 2>&1; then 
  echo "= Uninstalling PHP."
  sleep 2s
  yum remove php php-* -y
fi
if command -v mysql >/dev/null 2>&1; then 
  echo "= Uninstalling MariaDB."
  sleep 2s
  yum remove MariaDB MariaDB-* -y
fi

# 3. Judging that the package is uninstalled.
checkNginx=`rpm -qa | grep nginx`
checkApache=`rpm -qa | grep httpd`
checkPHP=`rpm -qa | grep php`
checkMariaDB=`rpm -qa | grep MariaDB`
if [ -z "$checkNginx" ] && [ -z "$checkApache" ] && [ -z "$checkPHP" ] && [ -z "$checkMariaDB" ];then
  echo "= LAMP/LNMP uninstall successfully."
  sleep 2s
  exit 0
else
  echo "= LAMP/LNMP uninstall fails. Please contact us $contact."
  sleep 2s
  exit 1
fi