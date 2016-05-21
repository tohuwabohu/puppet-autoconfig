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
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class autoconfig (
  $www_root = $autoconfig::params::www_root,
) inherits autoconfig::params {
  validate_absolute_path($www_root)

  file { "${www_root}/.htaccess":
    ensure  => file,
    content => template('autoconfig/htaccess.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
  }
}
