#!/bin/sh

#
#/etc/init.d/sensu-client start
/opt/sensu/embedded/bin/ruby /opt/sensu/bin/sensu-client -b -c /etc/sensu/config.json -d /etc/sensu/conf.d -e /etc/sensu/extensions -p /var/run/sensu/sensu-client.pid -l /var/log/sensu/sensu-client.log -L info
