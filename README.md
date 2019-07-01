## 构建
docker build -t docker-squid3 .

## 运行
docker run -d --name docker-squid3 -p 3128:3128 -v $(pwd)/squid.conf:/etc/squid/squid.conf docker-squid3

## 日志
docker exec docker-squid3 tail -f /var/log/squid/access.log