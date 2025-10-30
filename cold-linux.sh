#!/bin/bash


export COLD=/mnt/cold
export COLD_TGT=x86_64-cold-linux-gnu
export COLD_DISK=/dev/sda

if ! grep -q "$COLD" /proc/mounts; then
	source setupdisk.sh "$COLD_DISK"
	sudo mount "${COLD_DISK}2" "$COLD"
	sudo chown -v $USER "$COLD"
fi

mkdir -pv $COLD/{sources,tools,boot,etc,bin,lib,sbin,usr,var}

case $(uname -m) in
	x86_64) mkdir -pv $COLD/lib64 ;;
esac


cp -rf *.sh chapter* packages.csv "$COLD/sources"
cd "$COLD/sources"
export PATH="$COLD/tools/bin:$PATH"


source download.sh

# CHAPTER 5
# for package in binutils gcc linux-api-headers glibc libstdc++; do
	# source packageinstall.sh 5 $package
# done

# CHAPTER 6
# for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
	# source packageinstall.sh 6 $package
# done

source fixchroot.sh


chmod ugo+x preparechroot.sh
chmod ugo+x insidechroot*.sh
chmod ugo+x teardownchroot.sh


sudo ./preparechroot.sh "$COLD"
for script in "/sources/insidechroot.sh" "/sources/insidechroot2.sh" "/sources/insidechroot3.sh" "/sources/insidechroot4.sh" "/sources/insidechroot5.sh"; do
	echo "RUNNING $script CHROOT ENVIRONMENT..."
	sleep 3
	sudo chroot "$COLD" /usr/bin/env -i \
		HOME=/root \
		TERM="$TERM" \
		PS1="(cold chroot) \u:\w\$" \
		PATH="/bin:/usr/bin:/sbin:/usr/sbin" \
		MAKEFLAGS="-j$(nproc)" \
		TESTSUITEFLAGS="-j$(nproc)" \
		/bin/bash --login +h -c "$script"
done
sudo ./teardownchroot.sh "$COLD" "$USER" "$(id -gn)"

