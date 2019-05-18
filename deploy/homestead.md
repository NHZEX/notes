镜像类型
  - virtualbox
  - hyperv
  - vmware_desktop
  - parallels

BOX下载地址:
    https://vagrantcloud.com/laravel/boxes/homestead/versions/{版本号}/providers/{镜像类型}.box

导入描述文件（务必不要放在中文路径内）
```json
{
    "name":"laravel/homestead",
    "versions":[
        {
            "version":"7.0.0",
            "providers":[
                {
                    "name":"virtualbox",
                    "url":"file:///D/homestead/homestead.box"
                }
            ]
        }
    ]
}
```

导入命令
``` vagrant box add homestead.json ```
