class libreoffice::openclipart {
  include packages

  file {
    '/opt/libreoffice5.2/share/gallery': 
      require => [ Package['libreoffice5.2']
		 , Package['openclipart-libreoffice'] ],
      recurse => true,
      source  => '/usr/lib/libreoffice/share/gallery';
  }

  Package <| title == "libreoffice5.2"
          or title == openclipart-libreoffice |>
}
