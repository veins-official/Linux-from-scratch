mkdir -v build
cd build

../configure --prefix=$COLD/tools \
	--with-sysroot=$COLD \
	--target=$COLD_TGT \
	--disable-nls \
	--enable-gprofng=no \
	--disable-werror \
	--enable-new-dtags \
	--enable-default-hash-style=gnu \
&& make \
&& make install

