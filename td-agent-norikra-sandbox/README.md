# README

## How to Use

 1. git clone
 1. change sandbox user's passowrd in Dockerfile
 1. change norikra server's IP in td-agent.conf.example
 1. docker build -t ${your_container} .
 1. docker run -d ${your_container}
 1. Please chech container IP via docker inspect ${container_id}.
 1. Please access to `http://${container_IP}/`
 1. and Please access to `http://${container_IP}:26578/` and `http://${container_IP}:24220/api/plugins.json`.
 
