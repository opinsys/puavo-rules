class libreoffice::voikko {
  include packages
  include packages::languages::fi

  file {
    '/opt/libreoffice5.2/share/extensions/voikko': 
      ensure  => link,
      require => [ Package['libreoffice5.2'], Package['libreoffice-voikko'] ],
      target  => '/usr/lib/libreoffice/share/extensions/voikko';
  }

  Package <| title == "libreoffice5.2"
          or title == libreoffice-voikko |>
}
