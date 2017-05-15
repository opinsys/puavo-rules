class nagios {
  include dpkg,
	  nagios::check,
	  puavo
  search nagios::check

  # makes checks that are virtual (defined with @check)
  check_disk {
    [ '/', '/boot', '/home', '/opt/ltsp/images', '/tmp', '/var', ]:
      check_tags => [ 'bootserver', ];
  }

  @check {
    'dhcp':
      cmdline => "/usr/lib/nagios/plugins/check_dhcp -i ltsp0 -s $ipaddress_ltsp0 -t 4 -u",
      require => Dpkg::Statoverride['/usr/lib/nagios/plugins/check_dhcp'],
      tag     => [ 'bootserver', ];

    'dns':
      cmdline => "/usr/lib/nagios/plugins/check_dns -H $puavo_domain",
      require => Package['nagios-plugins-standard'],
      tag     => [ 'bootserver', ];

    'image_sync':
      # Warn if the there hasn't been sync in last two days (60 * 60 * 24 * 2 = 172800).
      cmdline => '/usr/lib/nagios/plugins/check_file_age -w 172800 -c 0 -f /opt/ltsp/images/.puavo-bootserver-sync-images-ok',
      require => Package['nagios-plugins-basic'],
      tag     => [ 'bootserver', ];

    'ldap':
      cmdline => "/usr/lib/nagios/plugins/check_ldap -H ${puavo::fqpuavoname} -b $puavo_ldap_base -T",
      require => Package['nagios-plugins-standard'],
      tag     => [ 'bootserver', ];

    'raid':
      cmdline => $lsbdistcodename ? {
		   'precise' => '/usr/lib/nagios/plugins/check_linux_raid',
		   default   => '/usr/lib/nagios/plugins/check_raid',
		 },
      require => $lsbdistcodename ? {
		   'precise' => Package['nagios-plugins-standard'],
		   default   => Package['nagios-plugins-contrib'],
		 },
      tag     => [ 'bootserver', ];

    'total_procs':
      cmdline => '/usr/lib/nagios/plugins/check_procs -w 1200 -c 2400',
      require => Package['nagios-plugins-basic'],
      tag     => [ 'bootserver', ];

    'zombies':
      cmdline => '/usr/lib/nagios/plugins/check_procs -w 10 -c 50 -s Z',
      require => Package['nagios-plugins-basic'],
      tag     => [ 'bootserver', ];
  }

  @dpkg::statoverride {
    '/usr/lib/nagios/plugins/check_dhcp':       # set check_dhcp setuid root
      owner   => 'root',
      group   => 'nagios',
      mode    => 4750,
      require => Package['nagios-plugins-basic'],
      tag     => [ 'bootserver', ];
  }

  package {
    [ 'nagios-nrpe-server'
    , 'nagios-plugins-basic'
    , 'nagios-plugins-common'
    , 'nagios-plugins-standard' ]:
      ensure => present;
  }


  if $lsbdistcodename != 'precise' {
    package {
      'nagios-plugins-contrib':
        ensure => present;
    }
  }

  service {
    'nagios-nrpe-server':
      ensure  => running,
      require => Package['nagios-nrpe-server'];
  }
}
