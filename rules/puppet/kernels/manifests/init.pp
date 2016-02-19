class kernels {
  include kernels::dkms,
          kernels::grub_update,
          packages

  define kernel_link ($archsuffix, $kernel, $linkname, $linksuffix) {
    $kernelpkg = "linux-image-${kernel}"

    $linktarget = $archsuffix ? {
                    ''      => "${linkname}${linksuffix}-${architecture}",
                    default => "${linkname}-${kernel}${archsuffix}",
                  }

    if $architecture == 'i386' {
      if $archsuffix == '-i386' {
        $default_arch_link = "/boot/${linkname}-${kernel}${archsuffix}"

        # a hack to make a link:
        # "${default_arch_link}" --> "${linkname}-${kernel}"
        $exectitle = "default link for ${kernel} ${linkname} ${linksuffix} ${archsuffix}"
        exec {
          $exectitle:
            command => "/bin/ln -fns ${linkname}-${kernel} ${default_arch_link}",
            onlyif  => "/usr/bin/test \"$(/bin/readlink ${default_arch_link})\" != \"${linkname}-${kernel}\"",
            require => Package[$kernelpkg];
        }

        $required = Exec[$exectitle]
      } elsif $archsuffix == '-amd64' {
        $required = File["/boot/${linktarget}"]
      } else {
        $required = Package[$kernelpkg]
      }
    } else {
      $required = Package[$kernelpkg]
    }

    file {
      "/boot/${linkname}${linksuffix}":
        ensure  => link,
        require => $required,
        target  => $linktarget;
    }

    Package <| title == $kernelpkg |>
  }

  define arch_kernel_links ($kernel, $subname, $arch='') {
    $archsuffix = $arch ? { '' => '', default => "-$arch" }

    $linksuffix = $subname ? {
                    'default' => $archsuffix,
                    default   => "-${subname}${archsuffix}",
                  }

    kernel_link {
      "initrd.img-${kernel}-${subname}-${arch}":
        archsuffix => $archsuffix,
        kernel     => $kernel,
        linkname   => 'initrd.img',
        linksuffix => $linksuffix;

      "nbi.img-${kernel}-${subname}-${arch}":
        archsuffix => $archsuffix,
        kernel     => $kernel,
        linkname   => 'nbi.img',
        linksuffix => $linksuffix;

      "vmlinuz-${kernel}-${subname}-${arch}":
        archsuffix => $archsuffix,
        kernel     => $kernel,
        linkname   => 'vmlinuz',
        linksuffix => $linksuffix;
    }
  }

  define all_kernel_links ($kernel) {
    $subname = $title

    arch_kernel_links {
      "${subname}-${kernel}":
        kernel  => $kernel,
        subname => $subname;

      "${subname}-${kernel}-i386":
        arch    => 'i386',
        kernel  => $kernel,
        subname => $subname;

      "${subname}-${kernel}-amd64":
        arch    => 'amd64',
        kernel  => $kernel,
        subname => $subname;
    }
  }

  $default_kernel = $lsbdistcodename ? {
    'precise' => '3.2.0-69-generic',
    'trusty'  => '3.13.0-78-generic',
    'utopic'  => '3.16.0-61-generic',
    'vivid'   => '3.19.0-50-generic',
    'wily'    => '4.2.0-29-generic',
  }

  $hwgen2_kernel = $lsbdistcodename ? {
    'trusty' => $architecture ? {
                  'i386'  => '4.0.9.opinsys2',
                  default => $default_kernel,
                },
    default => $default_kernel,
  }

  $hwgen3_kernel = $lsbdistcodename ? {
    'trusty' => $architecture ? {
                  'i386'  => '4.2.8.opinsys2',
                  default => $default_kernel,
                },
    default => $default_kernel,
  }

  $legacy_kernel = $lsbdistcodename ? {
    'trusty' => $architecture ? {
                  'i386'  => '3.2.0-70-generic-pae',
                  default => $default_kernel,
                },
    default => $default_kernel,
  }

  $utopic_kernel = $lsbdistcodename ? {
                     'trusty' => '3.16.0-61-generic',
                     default  => $default_kernel,
                   }

  $vivid_kernel = $lsbdistcodename ? {
                    'trusty' => '3.19.0-50-generic',
                    default  => $default_kernel,
                  }

  $wily_kernel = $lsbdistcodename ? {
                   'trusty' => '4.2.0-29-generic',
                   default  => $default_kernel,
                 }

  $edge_kernel = $lsbdistcodename ? {
    'trusty' => $architecture ? {
                  'i386'  => '4.3.3.opinsys2',
                  default => $default_kernel,
                },
    default => $default_kernel,
  }

  $stable_kernel = $default_kernel

  all_kernel_links {
    'default': kernel => $default_kernel;
    'edge':    kernel => $edge_kernel;
    'hwgen2':  kernel => $hwgen2_kernel;
    'hwgen3':  kernel => $hwgen3_kernel;
    'legacy':  kernel => $legacy_kernel;
    'stable':  kernel => $stable_kernel;
    'utopic':  kernel => $utopic_kernel;
    'vivid':   kernel => $vivid_kernel;
    'wily':    kernel => $wily_kernel;
  }
}
