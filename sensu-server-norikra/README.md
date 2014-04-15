## Dockerfile for sensu-server

### How to Use

 1. git clone && cd repo
 1. `docker build -t your-image .`
 1. `docker run -t -i -p 8080 -p 5671 your-image /bin/bash`
 1. `run /root/start.sh`
 1. Please access to http://your-image:8080/

### memo

 * `rabbitmq` uses port `5671`
 * `sensu-dashboard` uses port `8080`
