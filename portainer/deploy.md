##
```yaml
version: '2'

services:
  portainer:
    image: portainer/portainer-ce
    restart: always
    ports:
      - "9000:9000"
    command: -H unix:///var/run/docker.sock
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

volumes:
  portainer_data:
```

## agent
```yaml
version: '3'

services:
  portainer:
    image: portainer/agent:latest
    restart: always
    environment:
      - EDGE=1
      - EDGE_ID={uuid}
      - EDGE_KEY={secret}
      - CAP_HOST_MANAGEMENT=1
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /var/lib/docker/volumes:/var/lib/docker/volumes
      - /:/host
      - portainer_agent_data:/data
    network_mode: bridge

volumes:
  portainer_agent_data:
```