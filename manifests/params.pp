# == Class pam::params
#
# This class is meant to be called from pam.
# It sets variables according to platform.
#
class pam::params {

  ## global parameters
  $root_group = $::operatingsystem ? {
    /(FreeBSD|Solaris)/ => 'wheel',
    default             => 'root',
  }

  case $::operatingsystem {
    'Debian', 'Ubuntu',
    'RedHat', 'CentOS', 'Amazon',
    'FreeBSD', 'Solaris': {
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
