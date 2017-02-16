class packages::languages::fi {
  @package {
    [ 'language-pack-gnome-fi' ]:
      tag => [ 'language-fi', 'thinclient', 'ubuntu', ];

    [ 'firefox-locale-fi'
    , 'kde-l10n-fi'
    , 'language-pack-fi'
    , 'language-pack-kde-fi'
    , 'libobasis5.3-fi'
    , 'libobasis5.3-fi-base'
    , 'libobasis5.3-fi-calc'
    , 'libobasis5.3-filter-data'
    , 'libobasis5.3-fi-math'
    , 'libobasis5.3-fi-res'
    , 'libobasis5.3-fi-writer'
    , 'libreoffice5.3-fi'
    , 'thunderbird-locale-fi' ]:
      tag => [ 'language-fi', 'ubuntu', ];
  }
}
