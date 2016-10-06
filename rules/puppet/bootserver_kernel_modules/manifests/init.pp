class bootserver_kernel_modules {
  define add {
    exec {
      "/usr/local/sbin/add-kernel-module $title":
        require => [ File['/usr/local/sbin/add-kernel-module'], ],
        unless => "/sbin/lsmod | /bin/grep -q '$title' && /bin/grep -q '^$title' /etc/modules";
    }
  }

  file {
    '/usr/local/sbin/add-kernel-module':
      content => template('bootserver_kernel_modules/add-kernel-module'),
      mode    => 755;

    '/etc/modprobe.d/ipmi-watchdog.conf':
      content => template('bootserver_kernel_modules/ipmi-watchdog.conf'),
      mode    => 644;
  }

  if $is_ipmi_available == undef {
    fail("is_ipmi_available fact is missing")
  }

  if $is_ipmi_available == "true" {
    bootserver_kernel_modules::add {
      [ 'ipmi_devintf', 'ipmi_msghandler', 'ipmi_si', 'ipmi_watchdog']:
        require => [ File['/etc/modprobe.d/ipmi-watchdog.conf'], ];
    }
  }
}
