#!/bin/sh
if [ -e "$1" ]
then
	exec $@
else
	ulimit -n unlimited
	ulimit -n
	exec /fileserver/fileserver.pss
fi
