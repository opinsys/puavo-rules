class chrome {
  include dpkg,
          packages

  dpkg::simpledivert {
    [ '/usr/bin/google-chrome-stable'
    , '/usr/share/applications/google-chrome.desktop' ]:
      ;
  }

  file {
    '/etc/apt/sources.list.d/google-chrome.list':
      require => Package['google-chrome-stable:amd64'],
      source  => 'puppet:///modules/chrome/google-chrome.list';

    '/usr/bin/google-chrome-stable':
      mode    => 755,
      require => Dpkg::Simpledivert['/usr/bin/google-chrome-stable'],
      source  => 'puppet:///modules/chrome/google-chrome-stable';

    '/usr/share/applications/google-chrome.desktop':
      require => Dpkg::Simpledivert['/usr/share/applications/google-chrome.desktop'],
      source  => 'puppet:///modules/chrome/google-chrome.desktop';
  }
}
