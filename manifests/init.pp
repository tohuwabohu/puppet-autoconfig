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
# [*config_dir*]
#   Set the directory which will contain the web server configuration
#
# === Authors
#
# Martin Meinhold <Martin.Meinhold@gmx.de>
#
# === Copyright
#
# Copyright 2014 Martin Meinhold, unless otherwise noted.
#
class autoconfig(
  $www_root   = params_lookup('www_root'),
  $config_dir = params_lookup('config_dir'),
) inherits autoconfig::params {
  validate_absolute_path($www_root)
  validate_absolute_path($config_dir)

  $apache_config = "${config_dir}/apache.conf"
  $nginx_config = "${config_dir}/nginx.conf"

  file { $config_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat { $apache_config:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat { $nginx_config:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
}
