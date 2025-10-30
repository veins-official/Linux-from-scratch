./configure --prefix=/usr \
	--build=$(sh support/config.guess) \
	--host=$COLD_TGT \
	--without-bash-malloc \
&& make \
&& make DESTDIR=$COLD install

ln -sv bash $COLD/bin/sh

