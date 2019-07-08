编写于 2019/07/06 （注意来源更新）

## 安装 [Docker CE](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

- 标准安装（Ubuntu）
```bash
# Uninstall old versions
apt-get remove docker docker-engine docker.io containerd runc
# Install Docker CE
apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
```

- 额外步骤-镜像加速

  阿里云加速[镜像](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)
```bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://your.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## 安装 [Docker Compose](https://docs.docker.com/compose/install/)

- 标准安装
```bash
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

- 版本升级
```bash
docker-compose migrate-to-labels
```

## 安装 [Portainer](https://portainer.readthedocs.io/en/latest/deployment.html)

```bash
mkdir -p ~/portainer
curl -L "https://downloads.portainer.io/docker-compose.yml" -o ~/portainer/docker-compose.yml
docker-compose up -d
```

### 创建容器网络

类型: 桥接  
名称: development  
子网: 172.12.0.0/16  
网关: 172.12.0.1  

## 安装 [Mysql](https://hub.docker.com/_/mysql)

暂时使用二进制安装

## 安装 [Gitea](https://docs.gitea.io/en-us/install-from-binary/)

接入网络: development  

## 安装 Mongo

使用镜像`mongo:latest`  
使用网桥`mongo-db`  
容器命名`mongo`  

## 安装 [Yapi](https://github.com/YMFE/yapi)

使用镜像`xiao0yy/yapi-docker` https://hub.docker.com/r/xiao0yy/yapi-docker  
使用网桥`mongo-db`  
执行初始化数据库```$ docker exec -it yapi npm run install-server```  


## 安装 [Socketlog:latest](https://github.com/luofei614/SocketLog)

Image
```
FROM node:10-alpine
RUN npm --registry https://registry.npm.taobao.org install -g socketlog-server
EXPOSE 1116/tcp 1229/udp
ENTRYPOINT ["/usr/local/bin/socketlog-server"]
```

## 