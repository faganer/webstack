# Web Stack

## 一、介绍

Web Stack是CentOS 6/7/8下安装PHP 7.0/7.1/7.2/7.3/7.4、MariaDB 5.5/10.1/10.2/10.3/10.4、Apache/nginx的脚本。

已测试环境：[阿里云](https://www.aliyun.li/fz0w)，[腾讯云](https://url.cn/5u5pGTn)。

免责声明：仅用于研究学习，切勿用在生产环境。

## 二、安装

```Shell
curl -O http://cdn.jsdelivr.net/gh/faganer/webstack@master/install.sh
chmod 777 install.sh
./install.sh
```

## 三、MySQL密码

### 1、初始密码
安装会全自动生成12位字母与数字组成的随机密码，注意安装结束的密码提示：

```txt
"The MySQL initialization password is: 随机密码"
```

如果忘记，请使用：

### 2、设置密码

```Shell
./mysql_secure.sh 'your_new_root_password'
```

### 3、重设密码

```Shell
./mysql_secure.sh 'your_old_root_password' 'your_new_root_password'
```

## 四、卸载

```Shell
curl -O http://cdn.jsdelivr.net/gh/faganer/webstack@master/uninstall.sh
chmod 777 uninstall.sh
./uninstall.sh
```

卸载过程中如果选择“Y”，将会删除MariaDB生成的所有MySQL数据，如果选择“N”则不会删除，手动删除请用：

```Shell
find / -name mysql | xargs rm -rf
```