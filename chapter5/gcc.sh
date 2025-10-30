mkdir mpfr gmp mpc

tar -xf ../mpfr-*.tar.xz -C mpfr --strip-components=1
tar -xf ../gmp-*.tar.xz -C gmp --strip-components=1
tar -xf ../mpc-*.tar.gz -C mpc --strip-components=1

case $(uname -m) in
	x86_64)
		sed -e '/m64=/s/lib64/lib/' \
			-i.orig gcc/config/i386/t-linux64
	;;
esac

mkdir -v build
cd build

../configure \
	--target=$COLD_TGT \
	--prefix=$COLD/tools \
	--with-glibc-version=2.41 \
	--with-sysroot=$COLD \
	--with-newlib \
	--without-headers \
	--enable-default-pie \
	--enable-default-ssp \
	--disable-nls \
	--disable-shared \
	--disable-multilib \
	--disable-threads \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-libstdcxx \
	--enable-languages=c,c++ \
&& make \
&& make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	`dirname $($COLD_TGT-gcc -print-libgcc-file-name)`/include/limits.h

