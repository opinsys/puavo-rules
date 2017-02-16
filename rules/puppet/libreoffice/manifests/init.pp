class libreoffice {
  include libreoffice::config,
	  packages

  # Use the KDE-interface by default, because Libreoffice 5 reveals
  # an annoying bug in the GTK-libraries in Ubuntu Trusty.
  file {
    '/etc/X11/Xsession.d/42puavo-setup-libreoffice':
      content => "SAL_USE_VCLPLUGIN=kde4\nexport SAL_USE_VCLPLUGIN\n",
      require => Package['libreoffice-kde'];
  }

  Package <| title == libreoffice-kde |>
}
