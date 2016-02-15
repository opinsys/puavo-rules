class desktop::dconf::chrome_on_panel {
  include desktop::dconf

  file {
    '/etc/dconf/db/chrome_on_panel.d':
      ensure => directory;

    '/etc/dconf/db/chrome_on_panel.d/chrome_on_panel':
      content => template('desktop/dconf_chrome_on_panel'),
      notify  => Exec['update dconf'];
  }
}
