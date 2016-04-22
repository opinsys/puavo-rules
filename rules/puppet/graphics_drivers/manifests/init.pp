class graphics_drivers {
  require packages      # We use "require" here, because things here should be
                        # done only after all packages have been installed,
                        # because we run ldconfig and save its output for
                        # later use.

  define driver_alternatives ($gl_conf_target, $machine) {
    $driver      = $title
    $ld_so_cache = "/etc/ld.so.cache-$driver"

    exec {
      "setup $driver alternatives":
        command =>
          "/usr/bin/update-alternatives \
               --set ${$machine}-linux-gnu_gl_conf $gl_conf_target \
             && /sbin/ldconfig \
             && /bin/cp -p /etc/ld.so.cache /etc/ld.so.cache-$driver",
        onlyif =>
          "/usr/bin/test /etc/ld.so.cache-mesa-amd64 -ot /etc/ld.so.cache";
    }
  }

  driver_alternatives {
    'mesa-i386':
      gl_conf_target => "/usr/lib/i386-linux-gnu/mesa/ld.so.conf",
      machine        => 'i386',
      require        => [ Driver_alternatives['nvidia']
                        , Package['libgl1-mesa-glx'] ];

    'mesa-amd64':
      gl_conf_target => "/usr/lib/x86_64-linux-gnu/mesa/ld.so.conf",
      machine        => 'x86_64',
      require        => [ Driver_alternatives['nvidia']
                        , Driver_alternatives['mesa-i386']
                        , Package['libgl1-mesa-glx:amd64'] ];

    'nvidia':
      before         => File['/etc/modprobe.d/nvidia-304_hybrid.conf'],
      gl_conf_target => '/usr/lib/nvidia-304/ld.so.conf',
      machine        => 'i386',
      notify         => [ Driver_alternatives['mesa-i386']
                        , Driver_alternatives['mesa-amd64'] ],
      require        => [ Package['nvidia-304']
                        , Package['nvidia-settings'] ];
  }

  file {
    # Nouveau must be blacklisted so we can use nvidia,
    # but "alias nouveau off" is a no-no.
    '/etc/modprobe.d/nvidia-304_hybrid.conf':
      content => template('graphics_drivers/blacklist-nouveau.conf');
  }

  Package <| title == libgl1-mesa-glx
          or title == 'libgl1-mesa-glx:amd64'
          or title == nvidia-304
          or title == nvidia-settings |>

}
