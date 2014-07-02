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
# [*apache_config_file*]
#   Set the path where to write the apache configuration
#
# [*nginx_config_file*]
#   Set the path where to write the nginx configuration
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
  $www_root           = $autoconfig::params::www_root,
  $config_dir         = $autoconfig::params::config_dir,
  $apache_config_file = undef,
  $nginx_config_file  = undef,
) inherits autoconfig::params {
  validate_absolute_path($www_root)
  validate_absolute_path($config_dir)

  $real_apache_config = empty($apache_config_file) ? {
    false   => $apache_config_file,
    default => "${config_dir}/apache.conf",
  }
  $real_nginx_config = empty($nginx_config_file) ? {
    false   => $nginx_config_file,
    default => "${config_dir}/nginx.conf",
  }

  file { $config_dir:
    ensure  => directory,
    recurse => true,
    purge   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat { $real_apache_config:
    owner => 'root',
    group => 'root',
    mode  => '0644',
    force => true,
  }

  concat { $real_nginx_config:
    owner => 'root',
    group => 'root',
    mode  => '0644',
    force => true,
  }
}
