class udev {
  include udev::android
  include udev::eject_fix
  include udev::udevtrigger_workaround
  include udev::unblock_wifi
}
