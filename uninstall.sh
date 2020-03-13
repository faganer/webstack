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

# 3.1 nginx
if command -v nginx >/dev/null 2>&1; then 
  echo "= Uninstalling nginx."
  sleep 2s
  yum remove nginx nginx-* -y
else 
  exit 0
fi

# 3.2 Apache
if command -v apachectl >/dev/null 2>&1; then 
  echo "= Uninstalling Apache."
  sleep 2s
  yum remove httpd httpd-* -y
else 
  exit 0
fi

# 3.3 PHP
if command -v php >/dev/null 2>&1; then 
  echo "= Uninstalling PHP."
  sleep 2s
  yum remove php php-* -y
else 
  exit 0
fi

# 3.4 MariaDB
if command -v mysql >/dev/null 2>&1; then 
  echo "= Uninstalling MariaDB."
  sleep 2s
  yum remove MariaDB MariaDB-* -y 
else 
  exit 0
fi

# 4. Determine which rpm packages have been uninstalled.

# 4.1 nginx
if command -v nginx >/dev/null 2>&1; then 
  echo "= Nginx did not uninstall successfully, please contact us $contact."
  sleep 2s
else
  echo "= Nginx uninstall successfully."
  sleep 2s
  exit 0
fi

# 4.2 Apache
if command -v apachectl >/dev/null 2>&1; then 
  echo "= Apache did not uninstall successfully, please contact us $contact."
  sleep 2s
else
  echo "= Apache uninstall successfully."
  sleep 2s
  exit 0
fi

# 4.3 PHP
if command -v php >/dev/null 2>&1; then 
  echo "= PHP did not uninstall successfully, please contact us $contact."
  sleep 2s
else
  echo "= PHP uninstall successfully."
  sleep 2s
  exit 0
fi

# 4.4 MariaDB
if command -v mysql >/dev/null 2>&1; then 
  echo "= MariaDB did not uninstall successfully, please contact us $contact."
  sleep 2s
else
  echo "= MariaDB uninstall successfully."
  sleep 2s
  exit 0
fi

# 5. Judging that the package is uninstalled.
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