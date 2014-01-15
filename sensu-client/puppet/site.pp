node default {
  class {'sensu':
    client => true,
    purge_config => true,
    rabbitmq_password => 'mypass',
    rabbitmq_ssl_private_key => "puppet:///mount_point/sensu/key.pem",
    rabbitmq_ssl_cert_chain => "puppet:///mount_point/sensu/cert.pem",
    rabbitmq_host => 'xxx.xxx.xxx.xxx',
    subscriptions => 'sensu-test',
  }
  package { 'nagios-plugins-basic': ensure => latest }
    sensu::check { "cron":
      handlers    => 'default',
      command     => '/usr/lib/nagios/plugins/check_procs -C cron -c 1:10',
      subscribers => 'sensu-test'
    }
}
