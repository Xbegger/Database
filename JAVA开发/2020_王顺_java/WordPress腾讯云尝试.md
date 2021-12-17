### 腾讯云尝试

#### **IP:110.40.151.53**

#### wordpress

1. 在远程socket连接中，输入命令`cat ~lighthouse/credentials.txt`

​		控制台输出wordpress的用户名和密码

```java
wordpress_username = admin
wordpress_password = S8hMk5Eh2)9-
mariadb_password = 058wNQ5o0G0e
```



#### 宝塔

```java
username: China92647486 / urz9g98m
password: e19000e0d0f0
```

```java
FTP账号资料
用户：www_thekingshun_xyz
密码：AKW5NpmWYiYRPLwr

数据库账号资料
数据库名：www_thekingshun_
用户：www_thekingshun_
密码：DGRCy7A8zHNrSefb
```

```java
FTP账号资料
用户：thekingshun_xyz
密码：jkSpKRdzK4cRwKre

数据库账号资料
数据库名：thekingshun_xyz
用户：thekingshun_xyz
密码：f587TBwt38nriFks
```



#### 开放8080端口(浏览器访问不了tomcat解决办法)

在linux上开启的tomcat使用浏览器访问不了。
主要原因在于防火墙的存在，导致的端口无法访问。
CentOS7使用==firewall==而不是==iptables==。所以解决这类问题可以通过==添加firewall的端口==，使其对我们需要用的端口开放。

> * 使用命令 firewall-cmd --state查看防火墙状态。得到结果是running或者not running
> * 在running 状态下，向firewall 添加需要开放的端口，如果没开启 systemctl start firewalld 开启即可
>   命令为 firewall-cmd --permanent --zone=public --add-port=8080/tcp //永久的添加该端口。去掉--permanent则表示临时。与之对应关闭的命令为firewall-cmd --zone=public --remove-port=8080/tcp --permanent
> * firewall-cmd --reload //加载配置，使得修改有效。
> * 使用命令 firewall-cmd --permanent --zone=public --list-ports //查看开启的端口，出现8080/tcp这开启正确
> * 再次使用外部浏览器访问，这出现tomcat的欢迎界面。
> * 查看netstat -tunlpclear



补充（CentOS7以下有专门的防火墙操作命令）：
开启防火墙的命令
     systemctl start firewalld.service
关闭防火墙的命令
    systemctl stop firewalld.service
开机自动启动
    systemctl enable firewalld.service
关闭开机自动启动
    systemctl disable firewalld.service
查看防火墙状态
    systemctl status firewalld下列显示表示没有问题。

查看设置是否有效

　　firewall-cmd --zone=public --query-port=8080/tcp

