class chromium {
  include dpkg,
          packages

  dpkg::simpledivert { '/usr/bin/chromium-browser': ; }

  file {
    '/usr/bin/chromium-browser':
      mode   => 755,
      source => 'puppet:///modules/chromium/chromium-browser';
  }

  Package <| title == chromium-browser |>
}
