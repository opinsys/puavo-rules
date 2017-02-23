class libreoffice::openclipart {
  include packages

  file {
    '/opt/libreoffice5.2/share/gallery': 
      ensure  => link,
      require => [ Package['libreoffice5.2']
		 , Package['openclipart-libreoffice'] ],
      target  => '/usr/lib/libreoffice/share/extensions/gallery';
  }

  Package <| title == "libreoffice5.2"
          or title == openclipart-libreoffice |>
}
