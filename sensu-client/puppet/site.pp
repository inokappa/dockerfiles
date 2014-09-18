node default {
  #
  file { '/etc/sensu/plugins/system':
    ensure => "directory",
  }
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
    sensu_plugin_version => installed,
    use_embedded_ruby => true,
    manage_services => false,
    client => true,
    purge_config => true,
    rabbitmq_password => 'mypass',
    rabbitmq_host => 'your rabbitmq ip address',
    rabbitmq_port => '5672',
    rabbitmq_vhost => '/sensu',
    subscriptions => 'test',
    client_name => "${fqdn}",
    client_address => "${ipaddress}",
    safe_mode => true
  }
  #package { 'nagios-plugins-basic': ensure => latest }
  sensu::check { "cron":
    handlers    => 'default',
    command     => '/usr/lib/nagios/plugins/check_procs -C cron -c 1:10',
    subscribers => 'sensu-test'
  }
  #package { 'sensu-plugin': ensure => latest, provider => 'gem'; }
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
