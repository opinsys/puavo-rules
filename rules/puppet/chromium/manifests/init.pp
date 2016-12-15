class chromium {
  include chromium::office365_tweaks,
          dpkg,
          packages

  define install_policy () {
    $policy_name = $title

    file {
      "/etc/chromium/policies/managed/${policy_name}.json":
	content => template("chromium/${policy_name}.json");

      "/etc/opt/chrome/policies/managed/${policy_name}.json":
	ensure  => link,
	require => File["/etc/chromium/policies/managed/${policy_name}.json"],
	target  => "/etc/chromium/policies/managed/${policy_name}.json";
    }
  }

  dpkg::simpledivert { '/usr/bin/chromium-browser': ; }

  file {
    [ '/etc/chromium'
    , '/etc/chromium/policies'
    , '/etc/chromium/policies/managed'
    , '/etc/opt'
    , '/etc/opt/chrome'
    , '/etc/opt/chrome/policies'
    , '/etc/opt/chrome/policies/managed' ]:
      ensure => directory;

    '/usr/bin/chromium-browser':
      mode   => 755,
      source => 'puppet:///modules/chromium/chromium-browser';
  }

  Package <| title == chromium-browser |>
}
