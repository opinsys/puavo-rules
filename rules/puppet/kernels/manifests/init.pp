class kernels {
  include kernels::dkms,
          kernels::grub_update,
          packages::kernels

  define kernel_link ($archsuffix, $kernel, $linkname, $linksuffix) {
    $kernelpkg = "linux-image-${kernel}"

    $linktarget = $archsuffix ? {
                    ''      => "${linkname}${linksuffix}-${architecture}",
                    default => "${linkname}-${kernel}${archsuffix}",
                  }

    if $archsuffix == "-${architecture}" {
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
    } elsif $archsuffix != '' {
      $required = File["/boot/${linktarget}"]
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

    if $architecture == 'i386' {
      arch_kernel_links {
        "${subname}-${kernel}-i386":
          arch    => 'i386',
          kernel  => $kernel,
          subname => $subname;
      }
    }

    arch_kernel_links {
      "${subname}-${kernel}":
        kernel  => $kernel,
        subname => $subname;

      "${subname}-${kernel}-amd64":
        arch    => 'amd64',
        kernel  => $kernel,
        subname => $subname;
    }
  }

  case $lsbdistcodename {
    'precise': {
      $precise_kernel = '3.2.0-69-generic'

      $default_kernel = $precise_kernel
    }
    'trusty': {
      $precise_kernel = '3.2.0-70-generic-pae'
      $trusty_kernel  = '3.13.0-78-generic'
      $utopic_kernel  = '3.16.0-61-generic'
      $vivid_kernel   = '3.19.0-50-generic'
      $wily_kernel    = '4.2.0-29-generic'
      $hwgen2_kernel  = '4.0.9.opinsys2'
      $hwgen3_kernel  = '4.2.8.opinsys2'
      $edge_kernel    = '4.3.3.opinsys2'

      $default_kernel = $trusty_kernel

      all_kernel_links {
        'edge':   kernel => $edge_kernel;
        'hwgen2': kernel => $hwgen2_kernel;
        'hwgen3': kernel => $hwgen3_kernel;
        'legacy': kernel => $precise_kernel;
        'stable': kernel => $trusty_kernel;
        'utopic': kernel => $utopic_kernel;
        'vivid':  kernel => $vivid_kernel;
        'wily':   kernel => $wily_kernel;
      }
    }
  }

  all_kernel_links {
    'default': kernel => $default_kernel;
  }

  #
  # kernel packages and modules
  #

  $bcmwl_dkms_module  = 'bcmwl/6.30.223.248+bdcom'
  $nvidia_dkms_module = 'nvidia-304/304.131'
  $r8168_dkms_module  = 'r8168/8.040.00'
  $all_dkms_modules   = [ $bcmwl_dkms_module
                        , $nvidia_dkms_module
                        , $r8168_dkms_module ]

  Packages::Kernels::Kernel_package {
    dkms_modules => $all_dkms_modules,
  }

  case $lsbdistcodename {
    'precise': {
      packages::kernels::kernel_package {
        $precise_kernel:
          package_tag => 'puavo',
          with_extra  => false;
      }
    }
    'trusty': {
      packages::kernels::kernel_package {
        $precise_kernel:
          package_tag => 'puavo',
          with_extra  => false;

        $trusty_kernel:
          package_tag => 'puavo';

        [ $utopic_kernel, $vivid_kernel, $wily_kernel ]:
          ;

        [ $hwgen2_kernel, $hwgen3_kernel ]:
          package_tag => 'puavo',
          with_dbg    => true,
          with_extra  => false;

        # the bcmwl-version does not compile for this kernel
        $edge_kernel:
          dkms_modules => [ $r8168_dkms_module, ],
          package_tag  => 'puavo',
          with_dbg     => true,
          with_extra   => false;
      }
    }
  }
}
