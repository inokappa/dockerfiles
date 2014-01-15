#!/bin/bash
##
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
