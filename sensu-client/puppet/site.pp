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
  exec{'get_check-ram':
    cwd     => "/etc/sensu/plugins/system/",
    command => "/usr/bin/wget -q https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/check-ram.rb",
    creates => "/etc/sensu/plugins/system/check-load.rb",
   }
  file{'/etc/sensu/plugins/system/check-ram.rb':
    mode => 0755,
    require => Exec["get_check-ram"],
  }
  #
  exec{'get_disk-metrics':
    cwd     => "/etc/sensu/plugins/system/",
    command => "/usr/bin/wget -q https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/disk-metrics.rb",
    creates => "/etc/sensu/plugins/system/disk-metrics.rb",
   }
  file{'/etc/sensu/plugins/system/disk-metrics.rb':
    mode => 0755,
    require => Exec["get_disk-metrics"],
  }
  #
  exec{'get_vmstat-metrics':
    cwd     => "/etc/sensu/plugins/system/",
    command => "/usr/bin/wget -q https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/vmstat-metrics.rb",
    creates => "/etc/sensu/plugins/system/vmstat-metrics.rb",
   }
  file{'/etc/sensu/plugins/system/vmstat-metrics.rb':
    mode => 0755,
    require => Exec["get_vmstat-metrics"],
  }
  #
  exec{'get_memory-metrics.rb':
    cwd     => "/etc/sensu/plugins/system/",
    command => "/usr/bin/wget -q https://raw.githubusercontent.com/sensu/sensu-community-plugins/master/plugins/system/memory-metrics.rb",
    creates => "/etc/sensu/plugins/system/memory-metrics.rb",
   }
  file{'/etc/sensu/plugins/system/memory-metrics.rb':
    mode => 0755,
    require => Exec["get_memory-metrics.rb"],
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
  sensu::check { "diskspace":
    handlers    => 'default',
    command => '/etc/sensu/plugins/system/check-disk.rb'
  }
  sensu::check { "loadaverage":
    handlers    => 'default',
    command => '/etc/sensu/plugins/system/check-load.rb'
  }
  sensu::check { "memory":
    handlers    => 'default',
    command => '/etc/sensu/plugins/system/check-ram.rb'
  }
  sensu::check { "disk-metrics":
    type => 'metric',
    handlers => ['datadog' , 'graphite'],
    command => '/etc/sensu/plugins/system/disk-metrics.rb'
  }
  sensu::check { "vmstat-metrics":
    type => 'metric',
    handlers => ['datadog' , 'graphite'],
    command => '/etc/sensu/plugins/system/vmstat-metrics.rb'
  }
  sensu::check { "memory-metrics":
    type => 'metric',
    handlers => ['datadog' , 'graphite'],
    command => '/etc/sensu/plugins/system/memory-metrics.rb'
  }
}
