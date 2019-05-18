docker-compose.yml
```yaml
version: '3'
services:
  drone-server:
    image: "drone/drone:1.0"
    restart: always
    ports:
      - 3350:80
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/drone100:/data
    environment:
      - DRONE_GITEA_SERVER=http://gitea.host:3000
      - DRONE_GIT_ALWAYS_AUTH=true
      - DRONE_RUNNER_CAPACITY=2
      - DRONE_GITEA=true
      - DRONE_SERVER_HOST=web.host:3350
      - DRONE_SERVER_PROTO=http
      - DRONE_TLS_AUTOCERT=false
      - DRONE_LOGS_COLOR=false
      - DRONE_LOGS_PRETTY=false
      - DRONE_LOGS_DEBUG=false
      - DRONE_USER_CREATE=username:admin,machine:false,admin:true,token:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```