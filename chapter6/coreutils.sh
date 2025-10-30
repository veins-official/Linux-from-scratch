./configure --prefix=/usr \
	--host=$COLD_TGT \
	--build=$(build-aux/config.guess) \
	--enable-install-program=hostname \
	--enable-no-install-program=kill,uptime \
&& make \
&& make DESTDIR=$COLD install

mv -v $COLD/usr/bin/chroot $COLD/usr/sbin
mkdir -pv $COLD/usr/share/man/man8
mv -v $COLD/usr/share/man/man1/chroot.1 $COLD/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $COLD/usr/share/man/man8/chroot.8

