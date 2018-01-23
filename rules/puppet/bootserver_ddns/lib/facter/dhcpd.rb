Facter.add('puavo_dhcpd_manual_override') do
  setcode do
    override_conf = IO.read('/etc/init/isc-dhcp-server.override') rescue ''
    override_conf.match(/^manual$/) ? 'true' : 'false'
  end
end
