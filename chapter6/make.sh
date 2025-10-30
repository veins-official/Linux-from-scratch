./configure --prefix=/usr \
	--without-guile \
	--host=$COLD_TGT \
	--build=$(build-aux/config.guess) \
&& make \
&& make DESTDIR=$COLD install

