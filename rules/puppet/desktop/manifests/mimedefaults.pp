class desktop::mimedefaults {
  require packages

  exec {
    'desktop-update-mime-database':
      command     => '/usr/bin/update-mime-database /usr/share/mime',
      refreshonly => true;
  }

  file {
    '/usr/share/applications/defaults.list':
       content => template('desktop/defaults.list');
  }

  file {
    '/etc/gnome/defaults.list':
       content => template('desktop/defaults.list');
  }

  file {
    '/usr/share/mime/packages/drracket.xml':
       source => 'puppet:///modules/desktop/drracket.xml',
       notify  => Exec['desktop-update-mime-database'];
  }

  Package <| title == desktop-file-utils |>
}
