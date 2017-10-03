#!/bin/sh
if [ -e "$1" ]
then
	exec $@
else
	ulimit -n unlimited
	ulimit -n
	mkdir -p /var/log/plumber
	mkdir -p /etc/plumber/log.cfg
	echo "ERROR /var/log/plumber/error.log ae" >> /etc/log/plumber
	echo "FATAL /var/log/plumber/error.log ae" >> /etc/log/plumber
	echo "default /var/log/plumber/info.log a" >> /etc/log/plumber

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
	echo exec /fileserver/fileserver.pss ${port} ${root}
fi
