sed '6031s/$add_dir//' -i ltmain.sh

mkdir -v build
cd build

../configure \
	--prefix=/usr \
	--build=$(../config.guess) \
	--host=$COLD_TGT \
	--disable-nls \
	--enable-shared \
	--enable-gprofng=no \
	--disable-werror \
	--enable-64-bit-bfd \
	--enable-new-dtags \
	--enable-default-hash-style=gnu \
&& make \
&& make DESTDIR=$COLD install

rm -v $COLD/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

