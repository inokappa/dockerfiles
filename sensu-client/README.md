## Dockerfile for sensu-client

### How to Use

 1. Checking your sensu server IP address.
 1. git clone && cd repo
 1. Please change to `rabbitmq_host` IP address(=sensu server's IP address.).
 1. `docker build -t your-image .`
 1. `docker run -t -i your-image /bin/bash`
 1. Please login container and run `/root/start.sh`
