class packages::languages::fi {
  @package {
    [ 'language-pack-gnome-fi' ]:
      tag => [ 'language-fi', 'thinclient', 'ubuntu', ];

    [ 'firefox-locale-fi'
    , 'kde-l10n-fi'
    , 'language-pack-fi'
    , 'language-pack-kde-fi'
    , 'libobasis5.2-fi'
    , 'libobasis5.2-fi-base'
    , 'libobasis5.2-fi-calc'
    , 'libobasis5.2-filter-data'
    , 'libobasis5.2-fi-math'
    , 'libobasis5.2-fi-res'
    , 'libobasis5.2-fi-writer'
    , 'libreoffice5.2-fi'
    , 'thunderbird-locale-fi' ]:
      tag => [ 'language-fi', 'ubuntu', ];
  }
}
