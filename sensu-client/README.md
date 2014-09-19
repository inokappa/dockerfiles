## Dockerfile for sensu-client

### How to Use

 1. Checking your RabbitMQ server IP address.
 1. git clone && cd repo
 1. Please change `rabbitmq_host`'s IP address(your RabbitMQ server's IP address.) in `puppet/site.pp`.
 1. `docker build -t your-image .`
 1. `docker run -t -d your-image:latest /root/start.sh`
