#配置文件

### 使用自动脚本

```bash
cf_safe.sh
```

### http 块引入配置
```
include x_cfg/cf_ip_check.conf;
include x_cfg/cf_realip.conf;
```

### 站点配置

```
include x_cfg/ip_var_allow.conf;
```
