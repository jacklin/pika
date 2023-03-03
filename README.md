# pika 

### 简介

Pika是一个可持久化的大容量redis存储服务，兼容string、hash、list、zset、set的绝大部分接口([兼容详情](https://github.com/Qihoo360/pika/wiki/pika-支持的redis接口及兼容情况))，解决redis由于存储数据量巨大而导致内存不够用的容量瓶颈，并且可以像redis一样，通过slaveof命令进行主从备份，支持全同步和部分同步，pika还可以用在twemproxy或者codis中来实现静态数据分片

二次编译pika，更易于在k8s部署

编译步骤：

一、需要先clone 源代码

```shell
git clone https://github.com/Qihoo360/pika.git
git submodule init
git submodule update 
```

二、使用docker build 构建镜像

```shell
docker build -m 8g -f PikaDockerfile -t jacklin/pika:latest .
```

