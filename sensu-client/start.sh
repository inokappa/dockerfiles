#!/bin/sh

export PATH=/opt/sensu/embedded/bin:$PATH:$PLUGINS_DIR:$HANDLERS_DIR
export GEM_PATH=/opt/sensu/embedded/lib/ruby/gems/2.0.0:$GEM_PATH
#
/usr/bin/puppet apply /etc/puppet/manifests/site.pp
#
if [ ! -d /var/run/sensu ];then
  mkdir /var/run/sensu
  chown sensu:sensu /var/run/sensu
fi
#
if [ -f /var/run/sensu/sensu-client.pid ];then
  rm -f /var/run/sensu/sensu-client.pid
fi
#
/opt/sensu/embedded/bin/ruby /opt/sensu/bin/sensu-client \
  -c /etc/sensu/config.json \
  -d /etc/sensu/conf.d \
  -e /etc/sensu/extensions \
  -p /var/run/sensu/sensu-client.pid \
  -l /var/log/sensu/sensu-client.log \
  -L info
