#autoconfig

##Overview

Puppet module to provide auto-discovery functionality for clients of certain services. At the moment, the module
supports only [Autoconfiguration for Thunderbird](https://developer.mozilla.org/en-US/docs/Mozilla/Thunderbird/Autoconfiguration).

##Usage

Setup the Thunderbird auto-configuration for a given domain. This will create all required files on disk which are
expected by Thunderbird when looking up the mail server configuration settings for the email domain `example.com`:

```
autoconfig::thunderbird { 'example.com': }
```

In order to make the configuration on disk accessible to Thunderbird, a web server vhost has to be provided which will
accept requests for the `autoconfig.example.com` domain and serve the content created by this module. The vhost
configuration is covered in the next section.

To use a custom mail server configuration you can provide your own file template via

```
autoconfig::thunderbird { 'example.com':
  template => 'path/to/custom/template',
}
```

##Vhost configuration

The module relies on a `.htaccess` file which maps multiple vhosts to one common directory structure. If you're using
the [puppetlabs/apache](https://forge.puppetlabs.com/puppetlabs/apache) module, the following vhost would work

```
$domains = [
  'foo.com',
  'bar.com',
]

$autoconfig_domains = prefix($domains, $autoconfig::params::thunderbird_subdomain)

apache::vhost { $autoconfig_domains:
  port           => '80',
  serveradmin    => 'root@example.com',
  docroot        => $autoconfig::www_root,
  manage_docroot => false,
  access_log     => false,
  error_log_file => 'vhost_autoconfig_error.log',
}
```

This will make the email configuration for `foo.com` and `bar.com` available to Thunderbird.


##Limitations

The module has been tested on the following operating systems. Testing and patches for other platforms are welcome.

* Debian Linux 6.0 (Squeeze)

[![Build Status](https://travis-ci.org/tohuwabohu/puppet-autoconfig.png?branch=master)](https://travis-ci.org/tohuwabohu/puppet-autoconfig)

##Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
