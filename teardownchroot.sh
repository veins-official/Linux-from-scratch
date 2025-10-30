#!/bin/bash


export COLD="$1"
export DIROWNER="$2"
export DIRGROUP="$3"

if [ "$COLD" == "" ]; then
	exit 1
fi


if [ -h $COLD/dev/shm ]; then
	rm -rf $COLD$(realpath /dev/shm)
else
	umount $COLD/dev/shm
fi

umount $COLD/run
umount $COLD/sys
umount $COLD/proc

umount $COLD/dev/pts
umount $COLD/dev

rm -f $COLD/dev/console
rm -f $COLD/dev/null


chown -R $DIROWNER:$DIRGROUP $COLD/{tools,boot,etc,bin,lib,sbin,usr,var}

case $(uname -m) in
	x86_64) chown -R $DIROWNER:$DIRGROUP $COLD/lib64 ;;
esac

