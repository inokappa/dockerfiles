#!/bin/bash
##
mkdir -p /etc/rabbitmq/ssl
#
cd /tmp && rm -rf /tmp/*
wget http://sensuapp.org/docs/0.12/tools/ssl_certs.tar
tar -xvf ssl_certs.tar
cd ssl_certs
./ssl_certs.sh generate
