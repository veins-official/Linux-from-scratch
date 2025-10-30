./configure --prefix=/usr \
	--host=$COLD_TGT \
	--build=$(build-aux/config.guess) \
	--disable-static \
	--docdir=/usr/share/doc/xz-$VERSION \
&& make \
&& make DESTDIR=$COLD install

rm -v $COLD/usr/lib/liblzma.la

