# 使用acme.sh申请
[参考1](https://github.com/Neilpang/acme.sh/wiki/%E8%AF%B4%E6%98%8E)
[参考2](https://my.oschina.net/kimver/blog/1634575#comment-list)

## 安装客户端
首先，按照官方所述，我们需要一个支持 [ACMEv2](https://letsencrypt.org/docs/client-options/) 的客户端，这里我们就选用 [acme.sh](https://github.com/Neilpang/acme.sh)。
按照 README 中的指导，我们只需要在终端中执行：
```bash
yum install socat
curl https://get.acme.sh | sh
source ~/.bashrc
```
##设置自动更新客户端
升级 acme.sh 到最新版 :
```bash
acme.sh --upgrade
```
开启自动升级:
```bash
acme.sh  --upgrade  --auto-upgrade
```
关闭自动升级:
```bash
acme.sh --upgrade  --auto-upgrade  0
```

## 手动申请
#### 验证域名
这个最简单的道理就不用多说了吧，这里我们选用 DNS TXT 记录验证域名所有权。为了方便我准备直接手动修改 DNS 记录，不使用各提供商的 Token。
```bash
acme.sh --issue -d "bitcat.cc" -d "*.bitcat.cc" --dns
```
取得 Domain: <ACME_CHALLENGE_STRING>
取得 TXT value: <ACME_CHALLENGE_STRING>
设置 TXT 解析记录
使用 dig _acme-challenge.bitcat.cc TXT 测试是否生效

#### 申请签发证书
由于上一步骤中我们已经尝试过申请证书签发，只是没有验证域名所有权，才去完成验证所有权这一步骤。
因此这里我们需要使用：
```bash
acme.sh --renew -d "bitcat.cc" -d "*.bitcat.cc" --dns
```
验证成功，生成证书
Your cert is in  /Users/makito/.acme.sh/bitcat.cc/bitcat.cc.cer 
Your cert key is in  /Users/makito/.acme.sh/bitcat.cc/bitcat.cc.key [私钥]
The intermediate CA cert is in  /Users/makito/.acme.sh/bitcat.cc/ca.cer
And the full chain certs is there:  /Users/makito/.acme.sh/bitcat.cc/fullchain.cer [证书链]

至此证书签发完成，根据输出信息的提示，你也可以在其中出现的路径下找到证书以及秘钥文件。
不过我们也能注意到最后两行的提示信息提示我们正在使用手动模式： 使用手动模式无法自动更新。

## 自动申请
我们选用的 acme.sh 其实是支持直接使用主流 DNS 提供商的 API 接口来完成域名验证以及一些相关操作的。
可参考 [这篇 README](https://github.com/Neilpang/acme.sh/blob/master/dnsapi/README.md)，其中包含了大部分主流 DNS 提供商的 Token 使用方法。
这里咱选择了 DNSPod，只需要在执行 acme.sh --issue ... 之前设定一下 Token 的相关变量即可：
```bash
export DP_Id="<ID>"
export DP_Key="<TOKEN>"
```
DNSPod 的 Token 可在[这里](https://www.dnspod.cn/console/user/security)进行申请和管理。
```bash
acme.sh --issue -d "bitcat.cc" -d "*.bitcat.cc" --dns dns_dp
```
验证成功，生成证书
Your cert is in  /root/.acme.sh/pr.ozxh.wang/pr.ozxh.wang.cer 
Your cert key is in  /root/.acme.sh/pr.ozxh.wang/pr.ozxh.wang.key [私钥]
The intermediate CA cert is in  /root/.acme.sh/pr.ozxh.wang/ca.cer 
And the full chain certs is there:  /root/.acme.sh/pr.ozxh.wang/fullchain.cer [证书链] 

## 自动安装证书
前面证书生成以后, 接下来需要把证书 copy 到真正需要用它的地方.
注意, 默认生成的证书都放在安装目录下: ~/.acme.sh/, 请不要直接使用此目录下的文件, 例如: 不要直接让 nginx/apache 的配置文件使用这下面的文件. 这里面的文件都是内部使用, 而且目录结构可能会变化.
正确的使用方法是使用 --installcert 命令,并指定目标位置, 然后证书文件会被copy到相应的位置, 例如:
```bash
acme.sh  --installcert  -d  <domain>.com   \
        --key-file   /etc/nginx/ssl/<domain>.key \
        --fullchain-file /etc/nginx/ssl/fullchain.cer \
        --reloadcmd  "service nginx force-reload"
```

## 宝塔面板ssl设配
先手动设置一次，然后配置自动更新
路径 /www/server/panel/vhost/ssl/pr.ozxh.wang/
```bash
acme.sh  --installcert  -d  pr.ozxh.wang   \
        --key-file   /www/server/panel/vhost/ssl/pr.ozxh.wang/privkey.pem \
        --fullchain-file /www/server/panel/vhost/ssl/pr.ozxh.wang/fullchain.pem \
        --reloadcmd  "service nginx force-reload"
```

## dpkey
OneDriveSetup
