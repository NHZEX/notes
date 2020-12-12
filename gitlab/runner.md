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
```

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