#autoconfig

##Overview

Puppet module to provide auto-discovery functionality for clients of certain services. At the moment, the module supports only
[Autoconfiguration for Thunderbird](https://developer.mozilla.org/en-US/docs/Mozilla/Thunderbird/Autoconfiguration).

##Usage

Setup the Thunderbird auto-configuration for a given domain

```
autoconfig::thunderbird { 'example.com': }
```

Enable the domain configuration in your web server by linking to the corresponding file in the configuration directory
(e.g. `/etc/autoconfig/apache.conf`). Make sure the subdomain `autoconfig.example.com` is pointing to the host where
your web server is running.

To use a custom `config-v1.1.xml`, you can use

```
autoconfig::thunderbird { 'example.com':
  template => 'path/to/custom/template',
}
```

Furthermore, you want to notify your web server when the autoconfig web server configuration changes

```
class { 'autoconfig':
  notify => Service['apache'],
}
```

##Limitations

The module has been tested on the following operating systems. Testing and patches for other platforms are welcome.

* Debian Linux 6.0 (Squeeze)

[![Build Status](https://travis-ci.org/tohuwabohu/puppet-autoconfig.png?branch=master)](https://travis-ci.org/tohuwabohu/tohuwabohu-autoconfig)

##Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
