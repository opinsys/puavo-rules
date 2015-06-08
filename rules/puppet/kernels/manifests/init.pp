class kernels {
  include kernels::grub_update
  require packages

  define kernel_link ($kernel, $linkname, $linksuffix) {
    file {
      "/boot/${linkname}${linksuffix}":
        ensure  => link,
        require => Packages::Kernels::Kernel_package[$kernel],
        target  => "${linkname}-${kernel}";
    }

    Packages::Kernels::Kernel_package <| title == $kernel |>
  }

  define all_kernel_links ($kernel='') {
    $subname = $title

    $linksuffix = $subname ? { 'default' => '', default => "-$subname", }

    kernel_link {
      "initrd.img-${kernel}-${subname}":
        kernel => $kernel, linkname => 'initrd.img', linksuffix => $linksuffix;

      "nbi.img-${kernel}-${subname}":
        kernel => $kernel, linkname => 'nbi.img', linksuffix => $linksuffix;

      "vmlinuz-${kernel}-${subname}":
        kernel => $kernel, linkname => 'vmlinuz', linksuffix => $linksuffix;
    }
  }

  $default_kernel = $lsbdistcodename ? {
    'precise' => '3.2.0-69-generic',
    'trusty'  => '3.13.0-55.91-generic',
    'utopic'  => '3.16.0-38-generic',
    'vivid'   => '3.19.0-18-generic',
  }

  $legacy_kernel = $lsbdistcodename ? {
    'trusty' => $architecture ? {
                  'i386'  => '3.2.0-70-generic-pae',
                  default => $default_kernel,
                },
    default => $default_kernel,
  }

  $utopic_kernel = $lsbdistcodename ? {
                     'trusty' => '3.16.0-38-generic',
                     default  => $default_kernel,
                   }

  $vivid_kernel = $lsbdistcodename ? {
                    'trusty' => '3.19.0-18-generic',
                    default  => $default_kernel,
                  }

  $edge_kernel = $lsbdistcodename ? {
    'trusty' => $architecture ? {
                  'i386'  => '4.0.4.opinsys1',
                  default => $default_kernel,
                },
    default => $default_kernel,
  }

  $stable_kernel = $default_kernel

  $stable_amd64_kernel = $architecture ? {
                           'i386'  => '3.13.0-46-generic',
                           default => $stable_kernel,
                         }

  all_kernel_links {
    'default':      kernel => $default_kernel;
    'edge':         kernel => $edge_kernel;
    'legacy':       kernel => $legacy_kernel;
    'stable':       kernel => $stable_kernel;
    'stable-amd64': kernel => $stable_amd64_kernel;
    'utopic':       kernel => $utopic_kernel;
    'vivid':        kernel => $vivid_kernel;
  }
}
