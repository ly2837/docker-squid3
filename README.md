## 构建
``` shell
docker build -t docker-squid3 .
``` 
## 运行 1
``` shell
docker run -d --restart=always --name docker-squid3 \
    -p 3128:3128 \
    -v $(pwd)/squid.conf:/etc/squid/squid.conf \
    docker-squid3

docker stop docker-squid3 && docker rm docker-squid3

docker exec docker-squid3 tail -f /var/log/squid/access.log
``` 
## 运行 2
``` shell
mkdir /var/log/squid/
chown proxy:proxy /var/log/squid/

docker run -d --restart=always --name docker-squid3 \
    -p 3128:3128 \
    -v $(pwd)/squid.conf:/etc/squid/squid.conf \
    -v /var/log/squid/:/var/log/squid/ \
    docker-squid3

docker stop docker-squid3 && docker rm docker-squid3

tail -f /var/log/squid/access.log
```
## 其它
- 配置文件
/etc/squid/squid.conf
``` shell
http_port 3128 # 监听端口

http_access allow all # 允许所有用户访问
```

- 访问控制
``` shell
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
acl auth_user proxy_auth REQUIRED
http_access allow auth_user
```

- 密钥文件 /etc/squid/passwd
``` shell
apt install apache2-utils
htpasswd -b -c $(pwd)/passwd testuser testuser
htpasswd -b $(pwd)passwd testuser testuser
```
``` shell
docker run -d --restart=always --name docker-squid3 \
    -p 3128:3128 \
    -v $(pwd)/squid.ncsa_auth.conf:/etc/squid/squid.conf \
    -v $(pwd)/passwd:/etc/squid/passwd \
    -v /var/log/squid/:/var/log/squid/ \
    docker-squid3
```
- 相关命令
``` shell
squid -z # 初始化squid.conf里的cache目录

squid -N -d 1 # 前台启动squid
squid -s # 后台运行squid

squid -k parse # 对squid.conf进行排错
squid -k reconfigure # 重新引导修改过的squid.conf

squid -k shutdown # 停止
```