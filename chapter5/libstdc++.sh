mkdir -v build
cd build

../libstdc++-v3/configure \
	--host=$COLD_TGT \
	--build=$(../config.guess) \
	--prefix=/usr \
	--disable-multilib \
	--disable-nls \
	--disable-libstdcxx-pch \
	--with-gxx-include-dir=/tools/$COLD_TGT/include/c++/$VERSION \
&& make \
&& make DESTDIR=$COLD install

rm -v $COLD/usr/lib/lib{stdc++{,exp,fs},supc++}.la

