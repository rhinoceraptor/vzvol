#!/usr/bin/env sh
zvol_create_fs_fat32() {
	errorfunc='zvol_create_fs_fat32'
	echo "Creating FAT32 Filesystem on ${ZVOL_DEVICE_DIR}/${FORMAT_ME}"
	zvol_create_fs_fat32_linux -F32 "${ZVOL_DEVICE_DIR}/${FORMAT_ME}" || return 1
}
