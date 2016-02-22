class packages::kernels {
  include kernels::dkms,
          packages

  define foreign_arch_files ($foreign_arch,
                             $foreign_arch_basedir,
                             $kernel_version,
                             $filetype='file') {
    $titlearray = split($title, ' ')
    $fileprefix = $titlearray[0]

    if $filetype == 'file' {
      file {
        "/${fileprefix}${kernel_version}-${foreign_arch}":
          source => "${foreign_arch_basedir}/${fileprefix}${kernel_version}";
      }
    } elsif $filetype == 'directory' {
      # use exec/rsync for efficiency
      $sourcedir = "${foreign_arch_basedir}/${fileprefix}/${kernel_version}"
      $targetdir = "/${fileprefix}-${foreign_arch}/${kernel_version}"

      exec {
        "/usr/bin/rsync -a ${sourcedir}/ ${targetdir}.tmp/ && /bin/mv ${targetdir}.tmp ${targetdir}":
          creates => $targetdir,
          require => Package['rsync'];
      }

      Package <| title == rsync |>
    }
  }

  define foreign_arch_kernel_files ($foreign_arch,
                                    $foreign_arch_basedir,
                                    $with_dbg) {
    $kernel_version = $title

    if $with_dbg == 'true' {
      $dirprefixlist = [ 'lib/modules'
                       , 'usr/lib/debug/lib/modules' ]
    } else {
      $dirprefixlist = [ 'lib/modules' ]
    }

    $fileprefixlist = [ 'boot/abi-'
                      , 'boot/config-'
                      , 'boot/initrd.img-'
                      , 'boot/System.map-'
                      , 'boot/vmlinuz-' ]

    # Clunky tricks to retain compatibility the Puppet version (2.7.11)
    # in Precise, newer puppet versions could use iterations.
    $foreign_arch_dirs = regsubst($dirprefixlist,
                                  '$',
                                  " for ${kernel_version}")
    $foreign_arch_files = regsubst($fileprefixlist,
                                   '$',
                                   " for ${kernel_version}")

    foreign_arch_files {
      $foreign_arch_dirs:
        filetype             => 'directory',
        foreign_arch         => $foreign_arch,
        foreign_arch_basedir => $foreign_arch_basedir,
        kernel_version       => $kernel_version;

      $foreign_arch_files:
        foreign_arch         => $foreign_arch,
        foreign_arch_basedir => $foreign_arch_basedir,
        kernel_version       => $kernel_version;
    }
  }

  define kernel_package ($package_tag='',
                         $with_extra=true,
                         $with_dbg=false,
                         $pkgarch='',
                         $dkms_modules=[]) {
    $version = $title

    $pkgarch_postfix = $pkgarch ? { '' => '', default => ":$pkgarch", }

    $extra_packages = $with_extra ? {
      true  => [ "linux-image-extra-${version}${pkgarch_postfix}" ],
      false => [],
    }

    $dbg_packages = $with_dbg ? {
      true  => [ "linux-image-${version}-dbg${pkgarch_postfix}" ],
      false => [],
    }

    $packages = [ "linux-headers-${version}${pkgarch_postfix}"
                , "linux-image-${version}${pkgarch_postfix}"
                , $extra_packages
                , $dbg_packages ]

    # Clunky tricks to retain compatibility the Puppet version (2.7.11)
    # in Precise, newer puppet versions could use iterations.
    $dkms_modules_install_titles = regsubst($dkms_modules,
                                            '$',
                                            " for ${version}")
    kernels::dkms::install_dkms_module_for_kernel {
      $dkms_modules_install_titles:
        kernel_packages => $packages,
        kernel_version  => $version;
    }

    @package {
      $packages:
        tag => $package_tag ? {
                 ''      => 'kernel',
                 default => [ 'kernel', $package_tag, ],
               };
    }

    if $architecture == 'i386' {
      foreign_arch_kernel_files {
        $version:
          foreign_arch         => 'amd64',
          foreign_arch_basedir => '/mnt/amd64',
          with_dbg             => $with_dbg;
      }
    }
  }

  if $architecture == 'i386' {
    $foreign_arch = 'amd64'

    file {
      [ "/lib/modules-${foreign_arch}"
      , "/usr/lib/debug/lib/modules-${foreign_arch}" ]:
        ensure => directory;
    }
  }
}
