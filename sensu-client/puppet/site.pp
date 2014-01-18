node default {
  #
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

  class {'sensu':
    client => true,
    purge_config => true,
    rabbitmq_password => 'mypass',
    rabbitmq_ssl_private_key => "puppet:///mount_point/sensu/key.pem",
    rabbitmq_ssl_cert_chain => "puppet:///mount_point/sensu/cert.pem",
    rabbitmq_host => '172.17.0.72',
    subscriptions => 'sensu-test',
    client_name => "${hostname}"
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
