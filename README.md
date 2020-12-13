# Web Stack

## 一、介绍

Web Stack 是 CentOS 7/8 下安装 PHP 7.0/7.1/7.2/7.3/7.4/8.0、MariaDB 5.5/10.1/10.2/10.3/10.4/10.5、Apache/nginx 的脚本。

已测试环境：[阿里云](http://t.cn/A6qqokcl)，[腾讯云](https://url.cn/5u5pGTn)。

免责声明：仅用于研究学习，切勿用在生产环境。

## 二、安装

```Shell
chmod 777 install.sh
./install.sh
```

## 三、MySQL 密码

### 1、设置密码

```Shell
mysql_secure_installation
```

## 四、卸载

```Shell
chmod 777 uninstall.sh
./uninstall.sh
```

卸载过程中如果选择“Y”，将会删除 MariaDB 生成的所有 MySQL 数据，如果选择“N”则不会删除，手动删除请用：

```Shell
find / -name mysql | xargs rm -rf
```
