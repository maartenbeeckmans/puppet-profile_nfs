#
#
#
class profile_nfs::backup (
  Stdlib::AbsolutePath $mount_dir = $::profile_nfs::mount_dir,
) {
  include profile_rsnapshot::user

  @@rsnapshot::backup{ "backup ${facts['networking']['fqdn']} nfs-data":
    source     => "rsnapshot@${facts['networking']['fqdn']}:${mount_dir}",
    target_dir => "${facts['networking']['fqdn']}/nfs-data",
    tag        => lookup('rsnapshot_tag', String, undef, 'rsnapshot'),
  }
}
