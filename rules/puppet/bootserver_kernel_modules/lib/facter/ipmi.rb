Facter.add('is_ipmi_available') do
  setcode do
    # Decoce IPMI entry (Type 38) from the DMI table. Make dmidecode
    # to output nothing if IPMI entry is not found.
    output = Facter::Util::Resolution.exec('dmidecode -t 38 -q')

    # Succesful DMI table decoding is a necessity, otherwise the fact
    # retrieval has failed and IPMI availability is unknown.
    raise "dmidecode failed" if $? != 0

    # dmidecode did not output anything (strange that
    # Facter::Util::Resolution.exec() returns nil instead of an empty
    # string), IPMI is not available.
    next "false" if output.nil?

    # IPMI entry contains multiple fields, but we do not care about
    # its contents. We just consider its sole existence a proof of
    # IPMI availability.
    output.empty? ? "false" : "true"
  end
end
