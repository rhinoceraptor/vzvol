#!/usr/bin/env sh
zvol_create_fs_zfs() {
	errorfunc='zvol_create_fs_zfs'
	echo "Creating ZFS Filesystem on ${ZVOL_DEVICE_DIR}/${FORMAT_ME}"
	zpool create "${VOLNAME}" "${ZVOL_DEVICE_DIR}/${FORMAT_ME}" || return 1
}
zvol_create_fs_ufs() {
	errorfunc='zvol_create_fs_ufs'
	echo "Creating UFS Filesystem on ${ZVOL_DEVICE_DIR}/${FORMAT_ME}"
	newfs -E -J -O 2 -U "${ZVOL_DEVICE_DIR}/${FORMAT_ME}" || return 1
}
zvol_create_fs_fat32_freebsd() {
	newfs_msdos "$@"
}
zvol_create_fs_fat32_linux() {
	mkfs.fat "$@"
}
zvol_create_fs_ext2() {
	errorfunc='zvol_create_fs_ext2'
	echo "Creating ext2 Filesystem on ${ZVOL_DEVICE_DIR}/${FORMAT_ME}"
	mke2fs -t ext2 "${ZVOL_DEVICE_DIR}/${FORMAT_ME}" || return 1
}
zvol_create_fs_ext3() {
	errorfunc='zvol_create_fs_ext3'
	echo "Creating ext3 Filesystem on ${ZVOL_DEVICE_DIR}/${FORMAT_ME}"
	mke2fs -t ext3 "${ZVOL_DEVICE_DIR}/${FORMAT_ME}" || return 1
}
zvol_create_fs_ext4() {
	errorfunc='zvol_create_fs_ext4'
	echo "Creating ext4 Filesystem on ${ZVOL_DEVICE_DIR}/${FORMAT_ME}"
	mke2fs -t ext4 "${ZVOL_DEVICE_DIR}/${FORMAT_ME}" || return 1
}
zvol_create_fs_xfs() {
	errorfunc='zvol_create_fs_xfs'
	echo "Creating XFS Filesystem on ${ZVOL_DEVICE_DIR}/${FORMAT_ME}"
	mkfs.xfs "${ZVOL_DEVICE_DIR}/${FORMAT_ME}" || return 1
}
