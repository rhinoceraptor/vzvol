#!/bin/sh
vzvol_list() {
	vzvol_pre_list
	if [ $? = 2 ]; then
		echo "Error: no zvols configured"
		echo "Why not try creating one?"
		echo "It's as easy as: vzvol -t raw -v volumename"
		exit 1
	fi
	vzvol_pre_list
	if [ $? = 0 ]; then
		ZVOLS=$(vzvol_list_type)
		vzvol_pretty_print "$ZVOLS"
	else
		echo "Error acquiring zvol list"
		return 1
	fi
}
vzvol_pretty_print(){
	ZVOL_LIST="ZVOL TYPE VMDK USED SIZE FS \n$@"
	COLUMN_WIDTHS=$(echo "$ZVOL_LIST" | awk '{
		for (i = 1; i <= NF; i++) {
			maxWidth[i] = length($i) > maxWidth[i] ? length($i) : maxWidth[i]
		}
	} END {
		for (i = 1; i <= NF; i++) {
			printf "%s ", maxWidth[i]
		}
	}')

	echo "$COLUMN_WIDTHS\n$ZVOL_LIST" | awk '
		NR == 1 {
			for (i = 1; i <= NF; i++) {
				maxWidth[i] = $i
			}
		}
		NR != 1 {
			for (i = 1; i <= NF; i++) {
				printf "%-*s", maxWidth[i] + 2, $i
			}
			printf "\n"
		}'
}
vzvol_pre_list(){
	(zfs list -t volume 2>&1 | grep -q "no datasets available")
	if [ $? = 1 ]; then
		return 0
	else
		return 2
	fi
}
vzvol_list_type() {
	list_my_vols=$( zfs list -t volume | awk '!/NAME/ {print $1}' )
	if [ "$list_my_vols" = "no" ]; then
		echo "Error, No zvols Configured"
		return 2
	fi
	for vols in $list_my_vols; do
		purevolname=$( echo "$vols" | awk -F "/" '{print $2}' )
		purevolused=$( zfs get referenced "$vols" | awk '!/VALUE/ {print $3}' )
		purevolsize=$( zfs get used "$vols" | awk '!/VALUE/ {print $3}' )
		if zfs get custom:fs "$vols" 2>/dev/null | grep -q fs; then
			zvolfstype=$( zfs get custom:fs "$vols" | awk '!/VALUE/ {print $3}' )
		else
			zvolfstype="unknown"
		fi
		if [ -f "${HOME}/VBoxdisks/${purevolname}.vmdk" ]; then
			echo "${vols} VirtualBox ${HOME}/VBoxdisks/${purevolname}.vmdk $purevolused $purevolsize $zvolfstype"
		else
			echo "${vols} RAW none $purevolused $purevolsize $zvolfstype"
		fi
	done
	return 0
}
