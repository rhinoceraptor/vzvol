#!/usr/bin/env sh
vmdk_create() {
	errorfunc='vmdk_create'
	if [ ! -d "${ZUSER_HOME}"/VBoxdisks/ ]; then
		mkdir -p "${ZUSER_HOME}"/VBoxdisks/
	fi
	if [ ! -e "${ZUSER_HOME}"/VBoxdisks/"${VOLNAME}".vmdk ]; then
		echo "Creating ${ZUSER_HOME}/VBoxdisks/${VOLNAME}.vmdk"
		sleep 3
		VBoxManage internalcommands createrawvmdk \
		-filename "${ZUSER_HOME}"/VBoxdisks/"${VOLNAME}".vmdk \
		-rawdisk "${ZVOL_DEVICE_DIR}/${ZROOT}/${VOLNAME}"
	else
		echo "${ZUSER_HOME}/VBoxdisks/${VOLNAME}.vmdk" already exists.
		return 1
	fi
}
