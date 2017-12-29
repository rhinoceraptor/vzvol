#!/usr/bin/env sh
zvol_create() {
	errorfunc='zvol_create'
	if [ ! -e "${ZVOL_DEVICE_DIR}/${ZROOT}/${VOLNAME}" ]; then
		zfs create -V "${SIZE}" "${ZROOT}/${VOLNAME}"
	fi
	ZVOL_NAME="${ZVOL_DEVICE_DIR}/${ZROOT}/${VOLNAME}"
	sleep 5
	echo "Testing to ensure zvol was created"
	# TODO: check this works on MacOS
	if [ -L "${ZVOL_NAME}" ]; then
		ZVOL_NAME=/dev/$( file "${ZVOL_NAME}" | awk -F "/" '{print $7}' )
		vzvol_permissions
	elif [ -c "${ZVOL_NAME}" ]; then
		vzvol_permissions
	else
		echo "Error. ${ZVOL_NAME} not found"
		return 1
	fi
}
