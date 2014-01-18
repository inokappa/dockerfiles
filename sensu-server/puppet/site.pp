node default {
  file { '/etc/rabbitmq/ssl/key.pem':
    source => 'puppet:///mount_point/sensu/server/key.pem',
  }
  file { '/etc/rabbitmq/ssl/cert.pem':
    source => 'puppet:///mount_point/sensu/server/cert.pem',
  }
  file { '/etc/rabbitmq/ssl/cacert.pem':
    source => 'puppet:///mount_point/sensu/server/cacert.pem',
  }
  class { 'rabbitmq':
    ssl_key => '/etc/rabbitmq/ssl/key.pem',
    ssl_cert => '/etc/rabbitmq/ssl/cert.pem',
    ssl_cacert => '/etc/rabbitmq/ssl/cacert.pem',
    ssl => true,
  }
  rabbitmq_vhost { '/sensu': }
  rabbitmq_user { 'sensu': password => 'mypass' }
  rabbitmq_user_permissions { 'sensu@/sensu':
    configure_permission => '.*',
    read_permission => '.*',
    write_permission => '.*',
  }
  class {'redis': }
  class {'sensu':
    server => true,
    client => true,
    purge_config => true,
    rabbitmq_password => 'mypass',
    rabbitmq_ssl_private_key => "puppet:///mount_point/sensu/client/key.pem",
    rabbitmq_ssl_cert_chain => "puppet:///mount_point/sensu/client/cert.pem",
    rabbitmq_host => 'localhost',
    subscriptions => 'sensu-test',
  }
  package { 'nagios-plugins-basic': ensure => latest }
    sensu::check { "cron":
      handlers    => 'default',
      command     => '/usr/lib/nagios/plugins/check_procs -C cron -c 1:10',
      subscribers => 'sensu-test'
    }
}
