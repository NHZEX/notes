### 合并规则参考

```yaml
# Merge Template for clash verge
# The `Merge` format used to enhance profile

prepend-rules:
  - RULE-SET,custom_proxy,PROXY
  - RULE-SET,custom_direct,DIRECT

  - RULE-SET,applications,DIRECT
  - RULE-SET,private,DIRECT
  - RULE-SET,reject,REJECT
  - RULE-SET,icloud,DIRECT
  - RULE-SET,apple,DIRECT
  #- RULE-SET,google,DIRECT
  - RULE-SET,proxy,PROXY
  - RULE-SET,gfw,PROXY
  - RULE-SET,direct,DIRECT
  - RULE-SET,lancidr,DIRECT
  - RULE-SET,cncidr,DIRECT
  - RULE-SET,telegramcidr,PROXY
  - GEOIP,LAN,DIRECT
  - GEOIP,CN,DIRECT

prepend-proxies:

prepend-proxy-groups:

append-rules:

append-proxies:

append-proxy-groups:

rule-providers:
  direct:
    # 直连域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt"
    path: ./ruleset/direct.yaml
    interval: 86400

  proxy:
    # 代理域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/proxy.txt"
    path: ./ruleset/proxy.yaml
    interval: 86400

  reject:
    # 广告域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/reject.txt"
    path: ./ruleset/reject.yaml
    interval: 86400

  private:
    # 私有网络专用域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/private.txt"
    path: ./ruleset/private.yaml
    interval: 86400

  apple:
    # Apple 在中国大陆可直连的域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/apple.txt"
    path: ./ruleset/apple.yaml
    interval: 86400

  icloud:
    # iCloud 域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/icloud.txt"
    path: ./ruleset/icloud.yaml
    interval: 86400

  google:
    # [慎用] Google 在中国大陆可直连的域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/google.txt"
    path: ./ruleset/google.yaml
    interval: 86400

  gfw:
    # GFWList 域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/gfw.txt"
    path: ./ruleset/gfw.yaml
    interval: 86400

  tld-not-cn:
    # 非中国大陆使用的顶级域名列表
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/tld-not-cn.txt"
    path: ./ruleset/tld-not-cn.yaml
    interval: 86400

  telegramcidr:
    # Telegram 使用的 IP 地址列表
    type: http
    behavior: ipcidr
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/telegramcidr.txt"
    path: ./ruleset/telegramcidr.yaml
    interval: 86400

  lancidr:
    # 局域网 IP 及保留 IP 地址列表
    type: http
    behavior: ipcidr
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/lancidr.txt"
    path: ./ruleset/lancidr.yaml
    interval: 86400

  cncidr:
    # 中国大陆 IP 地址列表
    type: http
    behavior: ipcidr
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/cncidr.txt"
    path: ./ruleset/cncidr.yaml
    interval: 86400

  applications:
    # 需要直连的常见软件列表
    type: http
    behavior: classical
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/applications.txt"
    path: ./ruleset/applications.yaml
    interval: 86400

  custom_direct:
    # type: http
    behavior: classical
    # url: https://cdn.jsdelivr.net/gh/mo-han/mo-han-toolbox/etc/clash/custom_direct.yaml
    # url: https://github.com/mo-han/mo-han-toolbox/raw/master/etc/clash/custom_direct.yaml
    path: ./ruleset/custom_direct.yaml
    interval: 3600

  custom_proxy:
    # type: http
    behavior: classical
    # url: https://cdn.jsdelivr.net/gh/mo-han/mo-han-toolbox/etc/clash/custom_proxy.yaml
    # url: https://github.com/mo-han/mo-han-toolbox/raw/master/etc/clash/custom_proxy.yaml
    path: ./ruleset/custom_proxy.yaml
    interval: 3600

```