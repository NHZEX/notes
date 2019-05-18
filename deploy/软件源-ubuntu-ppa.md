## 替换 ppa-launchpad 软件源
```bash
find /etc/apt/sources.list.d/ -type f -name "*.list" -exec  sed  -i.bak -r  's#deb(-src)?\s*http(s)?://ppa.launchpad.net#deb\1 http\2://launchpad.proxy.ustclug.org#ig' {} \;
```

## 附录-更多源反代
https://lug.ustc.edu.cn/wiki/mirrors/help/revproxy
```
registry-1.docker.io          docker.mirrors.ustc.edu.cn
packages.elastic.co           elastic.proxy.ustclug.org
ppa.launchpad.net             launchpad.proxy.ustclug.org
archive.cloudera.com/cdh5/    cloudera.proxy.ustclug.org/cdh5/
downloads.lede-project.org    lede.proxy.ustclug.org
downloads.openwrt.org         openwrt.proxy.ustclug.org
registry.npmjs.org            npmreg.proxy.ustclug.org
www.npmjs.com                 npm.proxy.ustclug.org
fonts.gstatic.com             fonts-gstatic.proxy.ustclug.org
fonts.googleapis.com          fonts.proxy.ustclug.org
ajax.googleapis.com           ajax.proxy.ustclug.org
themes.googleusercontent.com  google-themes.proxy.ustclug.org
secure.gravatar.com           gravatar.proxy.ustclug.org
```
