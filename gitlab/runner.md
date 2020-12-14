## 部署指南
[docker模式部署](https://docs.gitlab.com/runner/install/docker.html)  
[注册Runner](https://docs.gitlab.com/runner/register/index.html#docker)  

## /etc/gitlab-runner/config.toml
```toml
concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "runner-166-docker"
  url = "http://192.168.254.9/"
  token = "MtovNzmcEgxu8mazbXfc"
  executor = "docker"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
    [runners.cache.azure]
  [runners.docker]
    tls_verify = false
    image = "docker:19.03.8"
    privileged = false
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache", "/builds:/builds"]
    shm_size = 0
    pull_policy = "always" # available: always, if-not-present, never
```

### 解决拉起本地镜像错误问题（Error response from daemon: pull access denied for ...）

- https://gitlab.com/gitlab-org/gitlab-foss/-/issues/49001  
- https://docs.gitlab.com/runner/executors/docker.html#how-pull-policies-work
- https://gitlab.com/gitlab-org/gitlab-runner/-/merge_requests/115  

pull_policy 设置为 `never` （副作用，无法拉起线上自编译镜像）

### 数据共享相关资料

- https://gitlab.com/gitlab-org/gitlab-foss/-/issues/47062  
- https://gitlab.com/gitlab-org/gitlab-foss/-/issues/62802
- https://gitlab.com/groups/gitlab-org/-/epics/1418  

## docker-compose.yml
```yaml
version: '3'

services:
  runner:
    image: gitlab/gitlab-runner:latest
    restart: always
    privileged: true
    network_mode: "bridge"
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - gitlab_runner_config:/etc/gitlab-runner

volumes:
  gitlab_runner_config:
```

## runner
```shell
gitlab-runner register -n \
  --url http://192.168.254.9/ \
  --registration-token "wGwKYCPutwsDLksptzfs" \
  --executor docker \
  --description "runner-166-docker" \
  --docker-image "docker:19.03.8" \
  --docker-volumes /var/run/docker.sock:/var/run/docker.sock
```