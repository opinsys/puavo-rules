class packages {
  require apt::default_repositories,
          apt::multiarch,
          opinsys_apt_repositories,
          packages::proposed_updates

  include packages::purged

  # install packages by default
  Package { ensure => present, }

  #
  # packages from the ubuntu repositories
  #

  @package {
    [ 'cpufreqd'
    , 'elinks'
    , 'ethtool'
    , 'expect'
    , 'fping'
    , 'gawk'
    , 'git'
    , 'iftop'
    , 'initramfs-tools'
    , 'inotify-tools'
    , 'iperf'
    , 'libstdc++5'
    , 'lm-sensors'
    , 'lshw'
    , 'lynx'
    , 'm4'
    , 'mlocate'
    , 'moreutils'
    , 'nmap'
    , 'powertop'
    , 'pv'
    , 'pwgen'
    , 'pwman3'
    , 'rsync'
    , 'screen'
    , 'setserial'
    , 'strace'
    , 'sudo'
    , 'sysstat'
    , 'tmux'
    , 'tshark'
    , 'w3m'
    , 'whois'
    , 'x11vnc'
    , 'xinput-calibrator' ]:
      tag => [ 'admin', 'thinclient', 'ubuntu', ];

    [ 'clusterssh'
    , 'dconf-tools'
    , 'pssh'
    , 'smartmontools'
    , 'terminator'
    , 'vinagre'
    , 'xbacklight' ]:
      tag => [ 'admin', 'ubuntu', ];

    [ 'libasound2-plugins'
    , 'mumble'
    , 'pavucontrol'
    , 'pavumeter'
    , 'pulseaudio-esound-compat'
    , 'timidity' ]:
      tag => [ 'audio', 'ubuntu', ];

    [ 'bash'
    , 'bridge-utils'
    , 'gdebi-core'
    , 'grub-pc'
    , 'lvm2'
    , 'nfs-common'
    , 'openssh-client'
    , 'openssh-server'
    , 'policykit-1'
    , 'pm-utils'
    , 'rng-tools'
    , 'ubuntu-standard'
    , 'udev'
    , 'vlan' ]:
      tag => [ 'basic', 'ubuntu', ];

    [ 'compizconfig-settings-manager'
    , 'compiz-plugins-extra'
    , 'indicator-power'
    , 'indicator-session'
    , 'lightdm'
    , 'lightdm-gtk-greeter'
    , 'lsb-invalid-mta'
    , 'network-manager-openvpn-gnome'
    , 'notify-osd'
    , 'onboard'
    , 'overlay-scrollbar'               # needed by accessibility stuff
    , 'python-appindicator'
    , 'python-gtk2'
    , 'python-notify'
    , 'shared-mime-info'
    , 'xul-ext-mozvoikko' ]:
      tag => [ 'desktop', 'ubuntu', ];

    [ 'ubuntu-restricted-addons'
    , 'ubuntu-restricted-extras' ]:
      tag => [ 'desktop', 'restricted', 'ubuntu', ];

    [ 'acct'
    , 'ack-grep'
    , 'build-essential'
    , 'bvi'
    , 'cdbs'
    , 'debconf-doc'
    , 'devscripts'
    , 'dh-make'
    , 'dpkg-dev'
    , 'fakeroot'
    , 'gdb'
    , 'gnupg'
    , 'libssl-dev'
    , 'libmono-winforms2.0-cil'
    , 'manpages-dev'
    , 'mono-complete'
    , 'monodevelop'
    , 'perl-doc'
    , 'pinfo'
    , 'translate-toolkit'
    , 'unetbootin'
    , 'vim-nox' ]:
      tag => [ 'devel', 'ubuntu', ];

    [ 'bcmwl-kernel-source'
    , 'dkms'
    , 'firmware-b43-installer'
    , 'libgl1-mesa-glx:i386'
    , 'libgl1-mesa-glx:amd64'
    , 'linux-firmware'
    , 'nvidia-304'
    , 'nvidia-settings'
    , 'r8168-dkms'
    , 'xserver-xorg-video-all' ]:
      tag => [ 'drivers', 'ubuntu', ];

    [ 'mutt' ]:
      tag => [ 'email', 'ubuntu', ];

    [ 'wine' ]:
      tag => [ 'emulation', 'ubuntu', ];

    [ 'fontconfig'
    , 'ttf-freefont'
    , 'xfonts-utils' ]:
      tag => [ 'fonts', 'ubuntu', ];

    # needs debconf seeds or such to set license accepted,
    # but package itself is okay
    [ 'ttf-mscorefonts-installer' ]:
      tag => [ 'fonts', 'ubuntu', ];

    [ 'dosbox'
    , 'extremetuxracer'
    , 'freeciv-client-gtk'
    , 'gbrainy'
    , 'gcompris'
    , 'gcompris-sound-en'
    , 'gcompris-sound-fi'
    , 'gcompris-sound-sv'
    , 'gnibbles'
    , 'gnotski'
    , 'gnubg'
    , 'gnuchess'
    , 'kanagram'
    , 'kdeedu'
    , 'khangman'
    , 'ktouch'
    , 'ktuberling'
    , 'kwordquiz'
    , 'laby'
    , 'lincity-ng'
    , 'luola'
    , 'neverball'
    , 'neverputt'
    , 'openttd'
    , 'pacman'
    , 'realtimebattle'
    , 'sgt-puzzles'
    , 'supertuxkart'
    , 'tuxmath'
    , 'tuxpaint'
    , 'tuxpaint-stamps-default'
    , 'xmoto' ]:
      tag => [ 'games', 'ubuntu', ];

    [ 'consolekit'
    , 'dbus-x11'
    , 'gnome-applets'
    , 'gnome-power-manager'
    , 'gnome-user-guide'
    , 'libgnome2-perl'
    , 'libgnomevfs2-bin'
    , 'libgnomevfs2-extra'

    # needed by (gnome|unity)-control-center accessibility settings
    , 'libunity-core-6.0-9'
 
    , 'libwayland-egl1-mesa'
    , 'notification-daemon'
    , 'thunderbird-gnome-support'
    , 'ubuntu-docs' ]:
      tag => [ 'gnome', 'ubuntu', ];

    [ 'blender'
    , 'dia'
    , 'dvgrab'
    , 'f-spot'
    , 'gimp'
    , 'gimp-data-extras'
    , 'gimp-gap'
    , 'gimp-plugin-registry'
    , 'gimp-ufraw'
    , 'gocr'
    , 'gthumb'
    , 'gtkam'
    , 'hugin'
    , 'inkscape'
    , 'jhead'
    , 'kdenlive'
    , 'kino'
    , 'kolourpaint4'
    , 'krita'
    , 'libav-tools'
    , 'libsane'
    , 'libsane-extras'
    , 'luciole'
    , 'mencoder'
    , 'mjpegtools'
    , 'mypaint'
    , 'nautilus-image-converter'
    , 'okular'
    , 'openshot'
    , 'photofilmstrip'
    , 'pinta'
    , 'pitivi'
    , 'python-lxml'
    , 'sane-utils'
    , 'stopmotion'
    , 'synfig'
    , 'synfigstudio'
    , 'xsane'
    , 'xzoom' ]:
      tag => [ 'graphics', 'ubuntu', ];

    [ 'kdump-tools' ]:
      tag => [ 'kernelutils', 'ubuntu', ];

    [ 'gobby'
    , 'irssi'
    , 'irssi-plugin-xmpp'
    , 'pidgin'
    , 'pidgin-libnotify'
    , 'pidgin-plugin-pack'
    , 'sflphone-gnome'
    , 'xchat' ]:
      tag => [ 'instant_messaging', 'ubuntu', ];

    [ 'laptop-mode-tools' ]:
      tag => [ 'laptop', 'ubuntu', ];

    [ 'banshee'
    , 'clam-chordata'
    , 'gnome-mplayer'
    , 'goobox'
    , 'gstreamer1.0-clutter'
    , 'gstreamer1.0-libav'
    , 'gstreamer1.0-plugins-bad'
    , 'gstreamer1.0-plugins-base'
    , 'gstreamer1.0-plugins-good'
    , 'gstreamer1.0-plugins-ugly'
    , 'gstreamer1.0-tools'
    , 'gtk-recordmydesktop'
    , 'kaffeine'
    , 'kscd'
    , 'libdvdread4'
    , 'me-tv'
    , 'ogmrip'
    , 'python-gst0.10'
    , 'vlc'
    , 'vlc-plugin-pulse'
    , 'x264'
    , 'xbmc' ]:
      tag => [ 'mediaplayer', 'ubuntu', ];

    [ 'audacity'
    , 'denemo'
    , 'fmit'
    , 'hydrogen'
    , 'lmms'
    , 'musescore'
    , 'musescore-soundfont-gm'
    , 'qsynth'
    , 'rakarrack'
    , 'rosegarden'
    , 'solfege'
    , 'soundconverter'
    , 'tuxguitar'
    , 'tuxguitar-jsa' ]:
      tag => [ 'music_making', 'ubuntu', ];

    [ 'amtterm'
    , 'wsmancli' ]:
      tag => [ 'network', 'ubuntu', ];

    [ 'calibre'
    , 'fbreader'
    , 'libreoffice'
    , 'libreoffice-base'
    , 'scribus'
    , 'scribus-doc'
    , 'tellico'
    , 'thunderbird'
    , 'vym' ]:
      tag => [ 'office', 'ubuntu', ];

    [ 'cdparanoia'
    , 'cdrdao'
    , 'cue2toc'
    , 'eject'
    , 'rhythmbox-plugin-cdrecorder'
    , 'sound-juicer' ]:
      tag => [ 'optical_media', 'ubuntu', ];

    [ 'gtklp' ]:
      tag => [ 'printing', 'ubuntu', ];

    [ 'arduino'
    , 'arduino-mk'
    , 'avr-libc'
    , 'basic256'
    , 'eclipse'
    , 'emacs24'
    , 'eric'
    , 'eric-api-files'
    , 'fritzing'
    , 'gcc-avr'
    , 'geany'
    , 'idle'
    , 'idle-python2.7'
    , 'idle-python3.4'
    , 'kompare'
    , 'kturtle'
    , 'lokalize'
    , 'pyqt4-dev-tools'
    , 'python-doc'
    , 'python-jsonpickle' # a dependency for
                          # http://meetedison.com/robot-programming-software/
    , 'python-pygame'
    , 'python-renpy'
    , 'pythontracer'
    , 'qt4-designer'
    , 'qt4-doc'
    , 'racket'
    , 'renpy'
    , 'scratch'
    , 'spe' ]:
      tag => [ 'programming', 'ubuntu', ];

    [ 'gftp-gtk'
    , 'libmotif4'	# required by icaclient
    , 'lftp'
    , 'remmina'
    , 'smbclient'
    , 'unison-gtk'
    , 'wget'
    , 'xtightvncviewer']:
      tag => [ 'remote_access', 'ubuntu', ];

    [ 'atomix'
    , 'avogadro'
    , 'celestia'
    , 'celestia-common-nonfree'
    , 'celestia-gnome'
    , 'gchempaint'
    , 'ghemical'
    , 'gnucap'
    , 'gnuplot'
    , 'gnuplot-x11'
    , 'kalzium'
    , 'kbruch'
    , 'kgeography'
    , 'kig'
    , 'kmplot'
    , 'kstars'
    , 'mandelbulber'
    , 'marble-qt'
    , 'pspp'
    , 'qgis'
    , 'rkward'
    , 'stellarium'
    , 'texlive-fonts-extra'
    , 'texlive-fonts-recommended'
    , 'texlive-latex-extra'
    , 'texlive-latex-recommended'
    , 'wxmaxima' ]:
      tag => [ 'science', 'ubuntu', ];

    [ 'ubuntu-mono' ]:
      tag => [ 'themes', 'thinclient', 'ubuntu', ];

    [ 'breathe-icon-theme'
    , 'edubuntu-wallpapers'
    , 'gnome-icon-theme'
    , 'gnome-themes-extras'
    , 'gnome-themes-ubuntu'
    , 'gtk2-engines'
    , 'gtk2-engines-pixbuf'
    , 'human-theme'
    , 'light-themes'
    , 'openclipart'
    , 'oxygen-icon-theme'
    , 'pidgin-themes'
    , 'screensaver-default-images'
    , 'tangerine-icon-theme'
    , 'ubuntu-wallpapers'
    , 'xscreensaver-data'
    , 'xscreensaver-data-extra' ]:
      tag => [ 'themes', 'ubuntu', ];

    [ 'ubuntu-wallpapers-precise' ]:
      tag => [ 'backgroundimages', 'themes', 'ubuntu', 'precise', 'trusty', ];

    [ 'ubuntu-wallpapers-quantal'
    , 'ubuntu-wallpapers-raring'
    , 'ubuntu-wallpapers-saucy'
    , 'ubuntu-wallpapers-trusty' ]:
      tag => [ 'backgroundimages', 'themes', 'ubuntu', 'trusty', ];

    # the dependencies (and recommends) of ubuntu-gnome-desktop package
    # without a few packages that we do not want
    [ 'acpi-support'
    , 'aisleriot'
    , 'alsa-base'
    , 'alsa-utils'
    , 'anacron'
    , 'app-install-data-partner'
    , 'apport-gtk'
    , 'at-spi2-core'
    , 'avahi-autoipd'
    , 'avahi-daemon'
    , 'baobab'
    , 'bc'
    , 'bluez'
    , 'bluez-alsa'
    , 'bluez-cups'
    , 'brasero'
    , 'brltty'
    , 'ca-certificates'
    , 'cheese'
    , 'compiz'
    , 'cups'
    , 'cups-bsd'
    , 'cups-client'
    , 'cups-filters'
    , 'dconf-editor'
    # , 'deja-dup'				# not needed
    # , 'deja-dup-backend-cloudfiles'
    # , 'deja-dup-backend-gvfs'
    # , 'deja-dup-backend-s3'
    , 'empathy'
    , 'eog'
    , 'evince'
    , 'evolution'
    , 'file-roller'
    , 'firefox'
    , 'fonts-cantarell'
    , 'fonts-dejavu-core'
    , 'fonts-droid'
    , 'fonts-freefont-ttf'
    , 'fonts-kacst-one'
    , 'fonts-khmeros-core'
    , 'fonts-lao'
    , 'fonts-liberation'
    , 'fonts-lklug-sinhala'
    , 'fonts-nanum'
    , 'fonts-sil-abyssinica'
    , 'fonts-sil-padauk'
    , 'fonts-takao-pgothic'
    , 'fonts-thai-tlwg'
    , 'fonts-tibetan-machine'
    , 'foomatic-db-compressed-ppds'
    , 'gcc'
    , 'gcr'
    # , 'gdm'					# not needed
    , 'gedit'
    , 'genisoimage'
    , 'ghostscript-x'
    , 'gjs'
    , 'gnome-accessibility-themes'
    , 'gnome-backgrounds'
    , 'gnome-bluetooth'
    , 'gnome-calculator'
    , 'gnome-color-manager'
    , 'gnome-contacts'
    , 'gnome-control-center'
    , 'gnome-disk-utility'
    # , 'gnome-documents'	# forces tracker to be installed
				# (tracker is purged elsewhere)
    , 'gnome-font-viewer'
    , 'gnome-icon-theme-extras'
    , 'gnome-icon-theme-full'
    , 'gnome-icon-theme-symbolic'
    , 'gnome-keyring'
    , 'gnome-mahjongg'
    , 'gnome-menus'
    , 'gnome-mines'
    , 'gnome-online-accounts'
    , 'gnome-orca'
    , 'gnome-screenshot'
    , 'gnome-session'
    , 'gnome-session-canberra'
    , 'gnome-settings-daemon'
    , 'gnome-shell'
    , 'gnome-shell-extensions'
    , 'gnome-sudoku'
    , 'gnome-sushi'
    , 'gnome-system-log'
    , 'gnome-system-monitor'
    , 'gnome-terminal'
    , 'gnome-themes-standard'
    , 'gnome-tweak-tool'
    , 'gnome-user-share'
    , 'gnome-video-effects'
    , 'gsettings-desktop-schemas'
    , 'gstreamer0.10-alsa'
    , 'gstreamer0.10-pulseaudio'
    , 'gstreamer1.0-alsa'
    , 'gstreamer1.0-pulseaudio'
    , 'gucharmap'
    , 'gvfs-backends-goa'
    , 'gvfs-bin'
    , 'gvfs-fuse'
    , 'hplip'
    , 'i3'
    , 'ibus'
    , 'ibus-gtk3'
    , 'ibus-pinyin'
    , 'ibus-table'
    , 'inputattach'
    , 'itstool'
    , 'kerneloops-daemon'
    , 'laptop-detect'
    , 'libatk-adaptor'
    , 'libgail-common'
    , 'libnotify-bin'
    , 'libnss-mdns'
    , 'libnss-myhostname'
    , 'libpam-gnome-keyring'
    , 'libpam-systemd'
    , 'libproxy1-plugin-gsettings'
    , 'libproxy1-plugin-networkmanager'
    , 'libreoffice-calc'
    , 'libreoffice-gnome'
    , 'libreoffice-impress'
    , 'libreoffice-math'
    , 'libreoffice-ogltrans'
    , 'libreoffice-pdfimport'
    , 'libreoffice-presentation-minimizer'
    , 'libreoffice-style-tango'
    , 'libreoffice-writer'
    , 'libsasl2-modules'
    , 'libwmf0.2-7-gtk'
    , 'libxp6'
    , 'make'
    , 'mcp-account-manager-goa'
    , 'memtest86+'
    , 'mousetweaks'
    , 'mutter'
    , 'nautilus'
    , 'nautilus-sendto'
    # , 'nautilus-share' # forces software-properties-gtk to be installed
    , 'network-manager'
    , 'network-manager-pptp'
    , 'network-manager-pptp-gnome'
    , 'openprinting-ppds'
    , 'pcmciautils'
    # , 'plymouth-theme-ubuntu-gnome-logo'	# not needed
    # , 'plymouth-theme-ubuntu-gnome-text'	# not needed
    , 'policykit-desktop-privileges'
    , 'printer-driver-c2esp'
    , 'printer-driver-foo2zjs'
    , 'printer-driver-min12xxw'
    , 'printer-driver-pnm2ppa'
    , 'printer-driver-ptouch'
    , 'printer-driver-pxljr'
    , 'printer-driver-sag-gdi'
    , 'printer-driver-splix'
    , 'pulseaudio'
    , 'pulseaudio-module-bluetooth'
    , 'pulseaudio-module-x11'
    , 'python3-aptdaemon.pkcompat'
    , 'rfkill'
    , 'rhythmbox'
    , 'rhythmbox-plugin-magnatune'
    , 'rtmpdump'
    , 'rxvt-unicode'
    , 'seahorse'
    , 'shotwell'
    , 'simple-scan'
    , 'software-center'
    # , 'software-properties-gtk'		# (purged elsewhere)
    , 'speech-dispatcher'
    , 'ssh-askpass-gnome'
    , 'system-config-printer-gnome'
    , 'telepathy-idle'
    , 'totem'
    # , 'tracker'				# (purged elsewhere)
    , 'transmission-gtk'
    , 'ttf-indic-fonts-core'
    , 'ttf-punjabi-fonts'
    , 'ttf-ubuntu-font-family'
    , 'ubuntu-drivers-common'
    , 'ubuntu-extras-keyring'
    , 'ubuntu-gnome-default-settings'
    , 'ubuntu-gnome-wallpapers'
    # , 'ubuntu-release-upgrader-gtk'		# (purged elsewhere)
    , 'unzip'
    # , 'update-manager'			# (purged elsewhere)
    # , 'update-notifier'			# (purged elsewhere)
    , 'usb-creator-gtk'
    , 'vino'
    , 'whoopsie'
    , 'wireless-tools'
    , 'wpasupplicant'
    , 'xdg-user-dirs'
    , 'xdg-user-dirs-gtk'
    , 'xdg-utils'
    , 'xdiagnose'
    , 'xfce4'
    , 'xkb-data'
    , 'xorg'
    , 'xterm'
    , 'xul-ext-ubufox'
    , 'yelp'
    , 'yelp-tools'
    , 'yelp-xsl'
    , 'youtube-dl'
    , 'zenity'
    , 'zip'
    , 'zsync' ]:
      tag => [ 'ubuntu-gnome-desktop', 'ubuntu', ];

    [ 'bindfs'
    , 'desktop-file-utils'
    , 'devilspie'
    , 'duplicity'
    , 'exfat-fuse'
    , 'exfat-utils'
    , 'fuse'
    , 'gconf-editor'
    , 'ginn'
    , 'gkbd-capplet'
    , 'gpointing-device-settings'
    , 'ibus-libpinyin'
    , 'kdepasswd'
    , 'keepass2'
    , 'keepassx'
    , 'keychain'
    , 'khelpcenter4'
    , 'password-gorilla'
    , 'rarian-compat'
    , 'screenlets'
    , 'touchegg'
    , 'unace'
    , 'unionfs-fuse'
    , 'unrar'
    , 'x-tile' ]:
      tag => [ 'utils', 'ubuntu', ];

    [ 'qemu-kvm' ]:
      tag => [ 'virtualization', 'ubuntu', ];

    [ 'bluefish'
    , 'browser-plugin-vlc'
    , 'chromium-browser'
    , 'epiphany-browser'
    , 'icedtea-7-plugin'
    , 'liferea'
    , 'openjdk-8-jdk'
    , 'openjdk-8-jre'
    , 'perltidy'
    , 'php5-cli'
    , 'php5-sqlite'
    , 'sqlite3'
    , 'tidy'
    , 'weblint-perl' ]:
      tag => [ 'web', 'ubuntu', ];
  }

  #
  # packages from the (Opinsys) puavo repository
  #

  @package {
    [ 'nodejs-bundle'
    , 'puavo-rules'
    , 'puavo-devscripts' ]:
      tag => [ 'devel', 'puavo', ];

    [ 'autopoweroff'
    , 'ltsp-client'
    , 'opinsys-ca-certificates'
    , 'puavo-autopilot'
    , 'puavo-client'
    , 'puavo-hw-log'
    , 'puavo-ltsp-client'
    , 'puavo-ltsp-install'
    , 'puavo-monitor'
    , 'puavo-vpn-client' ]:
      tag => [ 'misc', 'puavo', 'thinclient', ];

    [ 'fluent-plugin-puavo'
    , 'iivari-client'
    , 'ltsp-server'
    , 'puavo-image-tools'
    , 'puavo-load-reporter'
    , 'puavo-local-config'
    , 'puavo-pkg'
    , 'puavo-sharedir-client'
    , 'puavo-wlanap'
    , 'simplescreenrecorder'
    , 'webmenu'
    , 'webkiosk-language-selector'
    , 'xexit' ]:
      tag => [ 'misc', 'puavo', ];

    [ 'dymo-cups-drivers' ]:
      tag => [ 'printing', 'puavo', ];

    [ 'bluegriffon'
    , 'enchanting'
    , 'pycharm'
    , 'snap4arduino' ]:
      tag => [ 'programming', 'puavo', ];

    [ 'x2goclient'
    , 'x2goserver' ]:
      tag => [ 'remote_access', 'puavo', ];

    [ 'faenza-icon-theme' ]:
      tag => [ 'themes', 'puavo', ];

    [ 'node-webkit' ]:
      tag => [ 'web', 'puavo', ];
  }

  #
  # packages from the canonical/ubuntu partner repository
  #

  @package {
    [ 'skype' ]:
      tag => [ 'instant_messaging', 'partner', 'extra', 'restricted' ];

    [ 'vmware-view-client' ]:
      tag => [ 'remote_access', 'partner', 'restricted' ];

    [ 'adobe-flashplugin' ]:
      tag => [ 'web', 'partner', 'extra', 'restricted' ];
  }

  # Packages which are not restricted per se, but which are required by
  # restricted packages. These need to be installed and distributed in
  # the image to minimize the effort of installing restricted packages
  # "during runtime".
  @package {
    [ 'libnspr4-0d' # spotify
    , 'libssl0.9.8' # spotify
    , 'lsb-core' ]: # google-earth
      tag => [ 'ubuntu', 'required-by-restricted' ];

    [ 'libudev0' ]: # spotify
      tag => [ 'puavo', 'required-by-restricted' ];
  }

  if $architecture == 'i386' {
    # "indicator-application" gets installed by some dependency (through
    # chrome-browser) as amd64-package on i386 for some reason.  There is
    # probably a better fix, but meanwhile forcing the native architecture
    # will do:
    package {
      "indicator-application:${architecture}":
        require => [ Package['libappindicator1:amd64']
                   , Package['libappindicator3-1:amd64']
                   , Package['libindicator3-7:amd64']
                   , Package['libindicator7:amd64'] ],
        tag => [ 'desktop', 'ubuntu', ];
    }
  }

  # some basic packages for amd64-environment that other packages need
  # but do not list as dependencies (because they presume that system
  # could not function at all without these... but it does, because base
  # system is i386).
  @package {
    # For 64-bit chrome.  We have an extensive list, so that google-chrome
    # can be installed as an addon, that is, we can get all its dependencies
    # without expecting the package to pull them.
    [ 'gtk2-engines-murrine:amd64'
    , 'libappindicator1:amd64'
    , 'libappindicator3-1:amd64'
    , 'libasn1-8-heimdal:amd64'
    , 'libasound2:amd64'
    , 'libasyncns0:amd64'
    , 'libatk-bridge2.0-0:amd64'
    , 'libatk1.0-0:amd64'
    , 'libatspi2.0-0:amd64'
    , 'libavahi-client3:amd64'
    , 'libavahi-common-data:amd64'
    , 'libavahi-common3:amd64'
    , 'libc6:amd64'
    , 'libcairo-gobject2:amd64'
    , 'libcairo2:amd64'
    , 'libcgmanager0:amd64'
    , 'libcolord1:amd64'
    , 'libcomerr2:amd64'
    , 'libcups2:amd64'
    , 'libcurl3:amd64'
    , 'libdatrie1:amd64'
    , 'libdb5.3:amd64'
    , 'libdbus-1-3:amd64'
    , 'libdbus-glib-1-2:amd64'
    , 'libdbusmenu-glib4:amd64'
    , 'libdbusmenu-gtk3-4:amd64'
    , 'libdbusmenu-gtk4:amd64'
    , 'libexif12:amd64'
    , 'libexpat1:amd64'
    , 'libffi6:amd64'
    , 'libflac8:amd64'
    , 'libfontconfig1:amd64'
    , 'libfreetype6:amd64'
    , 'libgcc1:amd64'
    , 'libgconf-2-4:amd64'
    , 'libgcrypt11:amd64'
    , 'libgdk-pixbuf2.0-0:amd64'
    , 'libglib2.0-0:amd64'
    , 'libgnutls26:amd64'
    , 'libgpg-error0:amd64'
    , 'libgraphite2-3:amd64'
    , 'libgssapi-krb5-2:amd64'
    , 'libgssapi3-heimdal:amd64'
    , 'libgtk-3-0:amd64'
    , 'libgtk2.0-0:amd64'
    , 'libharfbuzz0b:amd64'
    , 'libhcrypto4-heimdal:amd64'
    , 'libheimbase1-heimdal:amd64'
    , 'libheimntlm0-heimdal:amd64'
    , 'libhx509-5-heimdal:amd64'
    , 'libidn11:amd64'
    , 'libindicator3-7:amd64'
    , 'libindicator7:amd64'
    , 'libjasper1:amd64'
    , 'libjbig0:amd64'
    , 'libjpeg-turbo8:amd64'
    , 'libjpeg8:amd64'
    , 'libjson-c2:amd64'
    , 'libk5crypto3:amd64'
    , 'libkeyutils1:amd64'
    , 'libkrb5-26-heimdal:amd64'
    , 'libkrb5-3:amd64'
    , 'libkrb5support0:amd64'
    , 'liblcms2-2:amd64'
    , 'libldap-2.4-2:amd64'
    , 'liblzma5:amd64'
    , 'libnih-dbus1:amd64'
    , 'libnih1:amd64'
    , 'libnspr4:amd64'
    , 'libnss3:amd64'
    , 'libogg0:amd64'
    , 'libp11-kit0:amd64'
    , 'libpango-1.0-0:amd64'
    , 'libpango1.0-0:amd64'
    , 'libpangocairo-1.0-0:amd64'
    , 'libpangoft2-1.0-0:amd64'
    , 'libpangox-1.0-0:amd64'
    , 'libpangoxft-1.0-0:amd64'
    , 'libpcre3:amd64'
    , 'libpixman-1-0:amd64'
    , 'libpng12-0:amd64'
    , 'libpulse0:amd64'
    , 'libroken18-heimdal:amd64'
    , 'librtmp0:amd64'
    , 'libsasl2-2:amd64'
    , 'libsasl2-modules:amd64'
    , 'libsasl2-modules-db:amd64'
    , 'libselinux1:amd64'
    , 'libsndfile1:amd64'
    , 'libsqlite3-0:amd64'
    , 'libssl1.0.0:amd64'
    , 'libstdc++6:amd64'
    , 'libtasn1-6:amd64'
    , 'libthai0:amd64'
    , 'libtiff5:amd64'
    , 'libudev1:amd64'
    , 'libvorbis0a:amd64'
    , 'libvorbisenc2:amd64'
    , 'libwayland-client0:amd64'
    , 'libwayland-cursor0:amd64'
    , 'libwind0-heimdal:amd64'
    , 'libwrap0:amd64'
    , 'libx11-6:amd64'
    , 'libxau6:amd64'
    , 'libxcb-render0:amd64'
    , 'libxcb-shm0:amd64'
    , 'libxcb1:amd64'
    , 'libxcomposite1:amd64'
    , 'libxcursor1:amd64'
    , 'libxdamage1:amd64'
    , 'libxdmcp6:amd64'
    , 'libxext6:amd64'
    , 'libxfixes3:amd64'
    , 'libxft2:amd64'
    , 'libxi6:amd64'
    , 'libxinerama1:amd64'
    , 'libxkbcommon0:amd64'
    , 'libxrandr2:amd64'
    , 'libxrender1:amd64'
    , 'libxss1:amd64'
    , 'libxtst6:amd64'
    , 'zlib1g:amd64' ]:
      tag => [ '64bitchrome', 'ubuntu', ];
  }

  # Dropbox downloads updates to $HOME/.dropbox-dist directory
  # automatically and ends up using them instead of
  # nautilus-dropbox-dist. It's a bit unfortunate but still quite
  # fine. However, when running 64bit kernels, dropbox downloads 64bit
  # dropbox, which does not work without these libraries.
  @package {
    [ 'libice6:amd64'
    , 'libncurses5:amd64'
    , 'libsm6:amd64'
    , 'libxxf86vm1:amd64'
    , 'libxslt1.1:amd64' ]:
      tag => [ '64bitdropbox', 'ubuntu', ];
  }
}
