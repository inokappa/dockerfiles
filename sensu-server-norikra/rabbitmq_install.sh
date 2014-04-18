#!/bin/bash
##
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc
echo "deb     http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
apt-get update
apt-get install rabbitmq-server
#
mkdir -p /etc/rabbitmq/ssl
#
cd /tmp
wget http://sensuapp.org/docs/0.12/tools/ssl_certs.tar
tar -xvf ssl_certs.tar
cd ssl_certs
./ssl_certs.sh generate
#
cp /tmp/ssl_certs/sensu_ca/cacert.pem /etc/rabbitmq/ssl/
cp /tmp/ssl_certs/server/cert.pem /etc/rabbitmq/ssl/
cp /tmp/ssl_certs/server/key.pem /etc/rabbitmq/ssl/
#
cat << EOF >> /etc/rabbitmq/rabbitmq.config
[
    {rabbit, [
    {ssl_listeners, [5671]},
    {ssl_options, [{cacertfile,"/etc/rabbitmq/ssl/cacert.pem"},
                   {certfile,"/etc/rabbitmq/ssl/cert.pem"},
                   {keyfile,"/etc/rabbitmq/ssl/key.pem"},
                   {verify,verify_peer},
                   {fail_if_no_peer_cert,true}]}
  ]}
].
EOF
#
#/etc/init.d/rabbitmq-server start
#
#rabbitmqctl add_vhost /sensu
#rabbitmqctl add_user sensu mypass
#rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
