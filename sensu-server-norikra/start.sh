#!/bin/sh

/etc/init.d/rabbitmq-server start
/etc/init.d/redis-server start
#
rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu mypass
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
#
/etc/init.d/sensu-server start
/etc/init.d/sensu-api start
/etc/init.d/sensu-dashboard start
