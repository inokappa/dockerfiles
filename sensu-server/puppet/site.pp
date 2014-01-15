node default {
  file { '/etc/rabbitmq/ssl/key.pem':
    source => 'puppet:///files/sensu/key.pem',
  }
  file { '/etc/rabbitmq/ssl/cert.pem':
    source => 'puppet:///files/sensu/cert.pem',
  }
  file { '/etc/rabbitmq/ssl/cacert.pem':
    source => 'puppet:///files/sensu/cacert.pem',
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
    purge_config => true,
    rabbitmq_password => 'mypass',
    rabbitmq_ssl_private_key => "puppet:///files/sensu/client_key.pem",
    rabbitmq_ssl_cert_chain => "puppet:///files/sensu/client_cert.pem",
    rabbitmq_host => 'localhost',
    subscriptions => 'sensu-test',
  }
}
