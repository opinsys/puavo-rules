class desktop::mimedefaults {
  require packages

  exec {
    'desktop-update-mime-database':
      command     => '/usr/bin/update-mime-database /usr/share/mime',
      refreshonly => true;
  }

  file {
    '/etc/gnome/defaults.list':
       content => template('desktop/defaults.list');

    '/usr/share/applications/defaults.list':
       content => template('desktop/defaults.list');

    '/usr/share/mime/packages/drracket.xml':
       notify => Exec['desktop-update-mime-database'],
       source => 'puppet:///modules/desktop/drracket.xml';
  }

  Package <| title == desktop-file-utils |>
}
