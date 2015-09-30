# ## Fact packer_version
#
# ### Description
# This fact retrieves the version of packer installed on the system.  This is
# used for upgrading packer if greater version is specified than what is
# currently installed.
#
#
Facter.add("packer_version") do
  setcode do
    begin
      kernel = Facter.value('kernel').downcase
        case kernel
        when /linux|darwin/
          version = Facter::Util::Resolution.exec('/usr/local/bin/packer version')
        when 'windows'
          version = Facter::Util::Resolution.exec('C:\Windows\system32\packer version')
        end
        /\d.*$/.match(version)
    rescue
      nil
    end
  end
end
