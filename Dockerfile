FROM ubuntu:18.04

MAINTAINER liuyang <liuyang@ly2837.com>

RUN sed s/archive.ubuntu.com/mirrors.aliyun.com/g -i /etc/apt/sources.list \
    && sed s/security.ubuntu.com/mirrors.aliyun.com/g -i /etc/apt/sources.list \
    && apt update \
    && apt install -y squid3 

ADD entrypoint.sh ./

EXPOSE 3128

ENTRYPOINT ["./entrypoint.sh"]