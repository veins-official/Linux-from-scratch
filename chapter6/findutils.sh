./configure --prefix=/usr \
	--localstatedir=/var/lib/locate \
	--host=$COLD_TGT \
	--build=$(build-aux/config.guess) \
&& make \
&& make DESTDIR=$COLD install

