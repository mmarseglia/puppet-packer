packer
=======
[![Build Status](https://travis-ci.org/mmarseglia/puppet-packer.svg)](https://travis-ci.org/mmarseglia/puppet-packer)

## Description

This Puppet module installs the Packer software package from the
[official releases](http://www.packer.io/downloads.html).

This module will upgrade packer if you specify a new version later on.

## Usage

### Installation
```puppet
include packer
```

This module installs Packer into `/usr/local/bin`.  To install in another
directory use the `bin_dir` parameter.  If you deviate from the default
installation directory this module will not detect the currently installed
version.

```puppet
class { 'packer':
  bin_dir => '/opt/local/bin',
}
```

Specify version to install a specific version of Packer.

```puppet
class { 'packer':
  version => '0.7.5',
}
```

If you change `version` this module will upgrade or downgrade Packer
as appropriate.  You must use the default installation location for this
feature to work.

Use a proxy to download Packer.
```puppet
class { 'packer':
  proxy => 'https://example.com:8080',
}
```


### Uninstall
To uninstall Packer, set the `ensure` parameter to `absent`:

```puppet
class { 'packer':
  ensure => absent,
}
```

## Plugins
Install plugins using packer::plugin.

```puppet
packer::plugin { 'my-plugin' :
	version	=> 'v1.2.3',
}
```

## License
Apache License, Version 2.0

## Support
Please log tickets and issues at https://github.com/mmarseglia/puppet-packer
