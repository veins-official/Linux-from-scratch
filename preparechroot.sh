#!/bin/bash


export COLD="$1"

if [ "$COLD" == "" ]; then
	exit 1
fi


chown -R root:root $COLD/{tools,boot,etc,bin,lib,sbin,usr,var}

case $(uname -m) in
	x86_64) chown -R root:root $COLD/lib64 ;;
esac

mkdir -pv $COLD/{dev,proc,sys,run}

mknod -m 600 $COLD/dev/console c 5 1
mknod -m 666 $COLD/dev/null c 1 3

mount -v --bind /dev $COLD/dev
mount -v --bind /dev/pts $COLD/dev/pts

mount -vt proc proc $COLD/proc
mount -vt sysfs sysfs $COLD/sys
mount -vt tmpfs tmpfs $COLD/run

if [ -h $COLD/dev/shm ]; then
	install -v -d -m 1777 $COLD$(realpath /dev/shm)
else
	mount -vt tmpfs -o nosuid,nodev tmpfs $COLD/dev/shm
fi

