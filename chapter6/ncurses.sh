mkdir build
	pushd build
	../configure AWK=gawk
	make -C include
	make -C progs tic
popd

./configure --prefix=/usr \
	--host=$COLD_TGT \
	--build=$(./config.guess) \
	--mandir=/usr/share/man \
	--with-manpage-format=normal \
	--with-shared \
	--without-normal \
	--with-cxx-shared \
	--without-debug \
	--without-ada \
	--disable-stripping \
	AWK=gawk \
&& make \
&& make DESTDIR=$COLD TIC_PATH=$(pwd)/build/progs/tic install

ln -sv libncursesw.so $COLD/usr/lib/libncurses.so
sed -e 's/^#if.*XOPEN.*$/#if 1/' \
-i $COLD/usr/include/curses.h

