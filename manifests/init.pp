# == Class: pam
#
# Full description of class pam here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class pam (
  $root_group = $::pam::params::root_group,
) inherits ::pam::params {

  # validate parameters here

  class { '::pam::config': } ->
  Class['::pam']
}
