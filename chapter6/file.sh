mkdir build
	pushd build
	../configure --disable-bzlib \
		--disable-libseccomp \
		--disable-xzlib \
		--disable-zlib
	make
popd

./configure --prefix=/usr --host=$COLD_TGT --build=$(./config.guess) \
&& make FILE_COMPILE=$(pwd)/build/src/file \
&& make DESTDIR=$COLD install

rm -v $COLD/usr/lib/libmagic.la

