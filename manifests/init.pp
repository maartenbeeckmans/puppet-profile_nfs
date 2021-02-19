#
#
#
class profile_nfs (
  Stdlib::AbsolutePath $mount_dir,
  String               $data_device,
  Boolean              $server,
  String               $domain,
  String               $export_root,
  String               $root_clients,
  Boolean              $manage_firewall_entry,
  Hash                 $exports,
  Hash                 $export_defaults,
  Boolean              $nfs_backup,
  String               $mount_root,
) {
  if $server {
    include profile_nfs::server
  } else {
    include profile_nfs::client
  }
}
