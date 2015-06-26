# == Class pam::config
#
# This class is called from pam for service config.
#
# pam::entries:
#   only-user-in-group-wheel-can-su:
#     state: 'present'
#     service: 'su'
#     type: 'auth'
#     control: 'require'
#     module: 'pam_wheel.so'
#     arguments:
#       - 'group=wheel'
#       - 'use_uid'
#     position: 'before *[type="auth" and module="system-auth"]'
class pam::config {
  $pam_entries = hiera_hash('pam::entries', undef)

  $entry_parameter_defaults = {
    ensure => present,
  }

  if ($pam_entries) {
    create_resources(pam, $pam_entries, $entry_parameter_defaults)
  }
}
