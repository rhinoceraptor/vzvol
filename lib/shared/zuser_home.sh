#!/usr/bin/env sh
case "$( uname -s )" in
	FreeBSD|Linux|SunOS)
		ZUSER_HOME=$(getent passwd $ZUSER | awk '{split($0, a, ":"); print a[6]}')
	;;
	Darwin)
		ZUSER_HOME=/Users/${ZUSER}
	;;
esac



