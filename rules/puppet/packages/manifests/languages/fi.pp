class packages::languages::fi {
  @package {
    [ 'language-pack-gnome-fi' ]:
      tag => [ 'language-fi', 'thinclient', 'ubuntu', ];

    [ 'firefox-locale-fi'
    , 'kde-l10n-fi'
    , 'language-pack-fi'
    , 'language-pack-kde-fi'
    , 'libreoffice5.3-fi'
    , 'libreoffice-voikko'
    , 'thunderbird-locale-fi' ]:
      tag => [ 'language-fi', 'ubuntu', ];
  }
}
