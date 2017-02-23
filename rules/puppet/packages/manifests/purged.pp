class packages::purged {
  require packages      # install packages first, then purge

  # purge packages by default
  Package { ensure => purged, }

  @package {
    [ 'cups-pk-helper'		# we do not need this, and it has bugs
    , 'gnome-media'		# broken software

    # slows down login considerably
    # (runs dpkg-query without speed considerations)
    , 'im-config'

    , 'lilypond-doc'
    , 'lilypond-doc-html'
    , 'lilypond-doc-pdf'

    , 'linux-image-generic'             # we want to choose kernels explicitly

    , 'samba'				# not needed, gets into system as
					# some recommendation through winbind

    # we use the upstream packages for Libreoffice, not the Ubuntu ones
    , 'libreoffice'
    , 'libreoffice-avmedia-backend-gstreamer'
    , 'libreoffice-base'
    , 'libreoffice-base-core'
    , 'libreoffice-base-drivers'
    , 'libreoffice-calc'
    , 'libreoffice-common'
    , 'libreoffice-core'
    , 'libreoffice-draw'
    , 'libreoffice-gnome'
    , 'libreoffice-gtk'
    , 'libreoffice-impress'
    , 'libreoffice-java-common'
    , 'libreoffice-math'
    , 'libreoffice-pdfimport'
    , 'libreoffice-report-builder-bin'
    , 'libreoffice-sdbc-firebird'
    , 'libreoffice-sdbc-hsqldb'
    , 'libreoffice-style-galaxy'
    , 'libreoffice-style-human'
    , 'libreoffice-writer'
    , 'python3-uno'

    # the functionality in these is not for our end users
    , 'software-properties-gtk'
    , 'synaptic'

    , 'texlive-fonts-extra-doc'
    , 'texlive-fonts-recommended-doc'
    , 'texlive-latex-base-doc'
    , 'texlive-latex-extra-doc'
    , 'texlive-latex-recommended-doc'
    , 'texlive-pictures-doc'
    , 'texlive-pstricks-doc'

    , 'ubuntu-release-upgrader-core'

    , 'tftpd-hpa'               # this is suggested by ltsp-server, but
                                # we do not actually use tftpd on ltsp-server
                                # (we use a separate boot server)

    , 'tracker' ]:              # this uses too much resources when using nfs
      tag => [ 'ubuntu', ];
  }
}
