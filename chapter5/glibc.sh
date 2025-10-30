case $(uname -m) in
	i?86) ln -sfv ld-linux.so.2 $COLD/lib/ld-lsb.so.3
	;;
	x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $COLD/lib64
		ln -sfv ../lib/ld-linux-x86-64.so.2 $COLD/lib64/ld-lsb-x86-64.so.3
	;;
esac

patch -Np1 -i ../glibc-2.41-fhs-1.patch

mkdir -v build
cd build

echo "rootsbindir=/usr/sbin" > configparms

../configure \
	--prefix=/usr \
	--host=$COLD_TGT \
	--build=$(../scripts/config.guess) \
	--enable-kernel=5.4 \
	--with-headers=$COLD/usr/include \
	--disable-nscd \
	libc_cv_slibdir=/usr/lib \
&& make \
&& make DESTDIR=$COLD install

sed '/RTLDLIST=/s@/usr@@g' -i $COLD/usr/bin/ldd

echo 'int main(){}' | $COLD_TGT-gcc -xc -
readelf -l a.out | grep ld-linux
rm -v a.out

