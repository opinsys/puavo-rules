class desktop::dconf::chrome_on_panel {
  include desktop::dconf

  file {
    [ '/etc/dconf/db/chrome_on_panel.d'
    , '/etc/dconf/db/chrome_on_panel.d/locks' ]:
      ensure => directory;

    '/etc/dconf/db/chrome_on_panel.d/chrome_on_panel':
      content => template('desktop/chrome_on_panel'),
      notify  => Exec['update dconf'];
  }
}
