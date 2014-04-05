# == Class: autoconfig::params
#
# Manage default configuration parameters.
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class autoconfig::params {
  $www_root = $::operatingsystem ? {
    default => '/var/www'
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/autoconfig'
  }
}
