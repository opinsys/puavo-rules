class libreoffice {
  include packages

  file {
    '/etc/puavo-external-files-actions.d/libreoffice':
      content => template('libreoffice/puavo-external-files-actions.d/libreoffice'),
      mode    => 755,
      require => Package['libreoffice5.3-writer'];
  }

  Package <| tag == "libreoffice5.3-writer" |>
}
