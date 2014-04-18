node default {
  ###################################################################
  file { '/etc/rabbitmq/ssl/key.pem':
    source => 'puppet:///mount_point/sensu/server/key.pem',
  }
  file { '/etc/rabbitmq/ssl/cert.pem':
    source => 'puppet:///mount_point/sensu/server/cert.pem',
  }
  file { '/etc/rabbitmq/ssl/cacert.pem':
    source => 'puppet:///mount_point/sensu/server/cacert.pem',
  }
  ###################################################################

  exec{'get_check-disk':
    cwd     => "/etc/sensu/plugins/system/",
    command => "/usr/bin/wget -q https://raw2.github.com/sensu/sensu-community-plugins/master/plugins/system/check-disk.rb",
    creates => "/etc/sensu/plugins/system/check-disk.rb",
  }
  file{'/etc/sensu/plugins/system/check-disk.rb':
    mode => 0755,
    require => Exec["get_check-disk"],
  }
  #
  exec{'get_check-load':
    cwd     => "/etc/sensu/plugins/system/",
    command => "/usr/bin/wget -q https://raw2.github.com/sensu/sensu-community-plugins/master/plugins/system/check-load.rb",
    creates => "/etc/sensu/plugins/system/check-load.rb",
   }
  file{'/etc/sensu/plugins/system/check-load.rb':
    mode => 0755,
    require => Exec["get_check-load"],
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
    client_name => "${hostname}",
    client_address => 'localhost'
  }
  package { 'nagios-plugins-basic': ensure => latest }
  sensu::check { "cron":
    handlers    => 'default',
    command     => '/usr/lib/nagios/plugins/check_procs -C cron -c 1:10',
    subscribers => 'sensu-test'
  }
  package { 'sensu-plugin': ensure => latest, provider => 'gem' }
  sensu::check { "diskspace":
    handlers    => 'default',
    command => '/etc/sensu/plugins/system/check-disk.rb',
    subscribers => 'sensu-test'
  }
  sensu::check { "loadaverage":
    handlers    => 'default',
    command => '/etc/sensu/plugins/system/check-load.rb',
    subscribers => 'sensu-test'
  }
}
