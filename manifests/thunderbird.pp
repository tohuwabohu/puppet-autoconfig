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
define autoconfig::thunderbird (
  $ensure   = present,
  $domain   = $name,
  $template = undef,
) {
  validate_re($ensure, '^present|absent$')

  include autoconfig

  $server_name = "autoconfig.${domain}"
  $mailserver = "mail.${domain}"
  $document_root = "${autoconfig::www_root}/${server_name}"
  $ensure_config_dir = $ensure ? {
    absent  => absent,
    default => directory,
  }
  $ensure_config_file = $ensure ? {
    absent  => absent,
    default => file,
  }
  $real_template = empty($template) ? {
    true    => 'autoconfig/thunderbird/config-v1.1.xml.erb',
    default => $template,
  }
  $ensure_config_fragment = $ensure ? {
    absent  => absent,
    default => present,
  }

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { $document_root:
    ensure  => $ensure_config_dir,
    purge   => true,
    recurse => true,
    force   => true,
  }

  file { "${document_root}/mail":
    ensure => $ensure_config_dir
  }

  file { "${document_root}/mail/config-v1.1.xml":
    ensure  => $ensure_config_file,
    content => template($real_template),
  }

  concat::fragment { "autoconfig_${domain}_apache":
    ensure  => $ensure_config_fragment,
    target  => $autoconfig::real_apache_config,
    content => template('autoconfig/vhost/apache.conf.erb'),
  }

  concat::fragment { "autoconfig_${domain}_nginx":
    ensure  => $ensure_config_fragment,
    target  => $autoconfig::real_nginx_config,
    content => template('autoconfig/vhost/nginx.conf.erb'),
  }
}
