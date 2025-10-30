#!/bin/bash

export COLD="$1"
shift

if [ "$COLD" == "" ]; then
	exit 1
fi

cp -rf *.sh chapter* packages.csv "$COLD/sources"

chmod ugo+x preparechroot.sh
chmod ugo+x teardownchroot.sh


sudo ./preparechroot.sh "$COLD"
sudo chroot "$COLD" /usr/bin/env -i \
	HOME=/root \
	TERM="$TERM" \
	PS1="(cold chroot) \u:\w\$ " \
	PATH="/bin:/usr/bin:/sbin:/usr/sbin" \
	COLD="" \
	/bin/bash --login +h $@
sudo ./teardownchroot.sh "$COLD" "$USER" "$(id -gn)"

