# == Define: autoconfig::thunderbird
#
# Configure the autoconfiguration feature of the Thunderbird email
# composer for a given domain.
#
# See https://developer.mozilla.org/en-US/docs/Mozilla/Thunderbird/Autoconfiguration
#
# === Parameters
#
# [*domain*]
#   Set the name of the domain to be auto-configured
#
# [*template*]
#   Use a custom template for the config file (config-v1.1.xml)
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
define autoconfig::thunderbird(
  $domain = $name,
  $template = undef,
) {
  require autoconfig

  $server_name = "autoconfig.${domain}"
  $mailserver = "mail.${domain}"
  $document_root = "${autoconfig::www_root}/${server_name}"
  $real_template = empty($template) ? {
    true    => 'autoconfig/thunderbird/config-v1.1.xml.erb',
    default => $template,
  }

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { $document_root:
    ensure  => directory,
    purge   => true,
    recurse => true,
  }

  file { "${document_root}/mail":
    ensure => directory
  }

  file { "${document_root}/mail/config-v1.1.xml":
    content => template($real_template),
  }

  concat::fragment { "autoconfig_${domain}_apache":
    target  => $autoconfig::apache_config,
    content => template('autoconfig/thunderbird/apache.conf.erb'),
  }

  concat::fragment { "autoconfig_${domain}_nginx":
    target  => $autoconfig::nginx_config,
    content => template('autoconfig/thunderbird/nginx.conf.erb'),
  }
}
