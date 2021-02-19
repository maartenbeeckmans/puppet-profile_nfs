#
#
#
class profile_nfs::client (
  String $domain         = $::profile_nfs::domain,
  String $mount_root     = $::profile_nfs::mount_root,
) {
  class { 'nfs':
    server_enabled      => false,
    client_enabled      => true,
    nfs_v4_client       => true,
    nfs_v4_mount_root   => $mount_root,
    nfs_v4_idmap_domain => $domain,
  }
}
