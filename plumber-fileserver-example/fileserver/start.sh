#!/bin/sh
if [ -e "$1" ]
then
	exec $@
else
	ulimit -n `ulimit -H -n`
	ulimit -n
	mkdir -p /var/log/plumber
	mkdir -p /etc/plumber
	echo "ERROR /var/log/plumber/error.log ae" >> /etc/plumber/log.cfg
	echo "FATAL /var/log/plumber/error.log ae" >> /etc/plumber/log.cfg
	echo "default /var/log/plumber/info.log a" >> /etc/plumber/log.cfg

	port=80
	root=/fileserver/environment/server_files
	
	for arg in $@
	do
		case ${arg} in
			--port=* )
				port=`echo ${arg} | sed 's/^[^=]*=\(.*\)$/\1/g'`
			;;
			--root=* )
				root=`echo ${arg} | sed 's/^[^=]*=\(.*\)$/\1/g'`
			;;
		esac
	done
	exec /fileserver/fileserver.pss ${port} ${root}
fi
