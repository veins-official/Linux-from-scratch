tar -xf ../mpfr-4.2.1.tar.xz
mv -v mpfr-4.2.1 mpfr
tar -xf ../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp
tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc

case $(uname -m) in
	x86_64)
		sed -e '/m64=/s/lib64/lib/' \
			-i.orig gcc/config/i386/t-linux64
	;;
esac

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
	-i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -v build
cd build

../configure \
	--build=$(../config.guess) \
	--host=$COLD_TGT \
	--target=$COLD_TGT \
	LDFLAGS_FOR_TARGET=-L$PWD/$COLD_TGT/libgcc \
	--prefix=/usr \
	--with-build-sysroot=$COLD \
	--enable-default-pie \
	--enable-default-ssp \
	--disable-nls \
	--disable-multilib \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libsanitizer \
	--disable-libssp \
	--disable-libvtv \
	--enable-languages=c,c++ \
&& make \
&& make DESTDIR=$COLD install

ln -sv gcc $COLD/usr/bin/cc

