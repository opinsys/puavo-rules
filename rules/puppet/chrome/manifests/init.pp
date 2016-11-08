class chrome {
  include dpkg,
          packages

  dpkg::simpledivert {
    [ '/usr/bin/google-chrome-stable'
    , '/usr/share/applications/google-chrome.desktop' ]:
      ;
  }

  exec {
    '/usr/local/sbin/puavo-get-pepperflash-amd64':
      creates => '/usr/lib/adobe-flashplugin/libpepflashplayer-amd64.so',
      require => File['/usr/local/sbin/puavo-get-pepperflash-amd64'];
  }

  file {
    '/etc/apt/sources.list.d/google-chrome.list':
      require => Package['google-chrome-stable:amd64'],
      source  => 'puppet:///modules/chrome/google-chrome.list';

    '/usr/bin/google-chrome-stable':
      mode    => 755,
      require => [ Dpkg::Simpledivert['/usr/bin/google-chrome-stable']
		 , Exec['/usr/local/sbin/puavo-get-pepperflash-amd64'] ],
      source  => 'puppet:///modules/chrome/google-chrome-stable';

    '/usr/local/sbin/puavo-get-pepperflash-amd64':
      mode   => 755,
      source => 'puppet:///modules/chrome/puavo-get-pepperflash-amd64';

    '/usr/share/applications/google-chrome.desktop':
      require => Dpkg::Simpledivert['/usr/share/applications/google-chrome.desktop'],
      source  => 'puppet:///modules/chrome/google-chrome.desktop';
  }
}
