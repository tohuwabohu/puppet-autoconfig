# == Class: autoconfig
#
# Enable autoconfiguration for service clients (e.g. email).
#
# === Parameters
#
# [*www_root*]
#   Set the www root directory where the files served by the web server
#   are stored
#
# [*domains*]
#   Set a list of domains for which the autoconfiguration should be activated.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class autoconfig (
  Stdlib::Absolutepath $www_root = $autoconfig::params::www_root,
  Array[String] $domains = [],
) inherits autoconfig::params {
  file { $www_root:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    purge   => true,
    recurse => true,
    force   => true,
  }

  file { "${www_root}/.htaccess":
    ensure  => file,
    content => template('autoconfig/htaccess.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    backup  => false,
  }

  autoconfig::thunderbird { $domains: }
}
