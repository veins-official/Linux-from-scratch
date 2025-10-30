export COLD=""
cd /sources

# CHAPTER 8
for package in man-pages iana-etc glibc zlib bzip2 xz lz4 zstd file readline m4 bc flex tcl expect dejagnu pkgconf binutils gmp mpfr mpc attr acl libcap libxcrypt shadow gcc ncurses sed psmisc gettext bison grep bash libtool gdbm gperf expat inetutils less perl xml::parser intltool autoconf automake openssl libelf libffi python flit-core wheel setuptools ninja meson kmod coreutils check diffutils gawk findutils groff grub gzip iproute2 kbd libpipeline make patch tar texinfo vim markupsafe jinja2 udev-lfs man-db procps util-linux e2fsprogs sysklogd sysvinit; do
	source packageinstall.sh 8 $package
done

rm -rf /tmp/{*,.*}

find /usr/lib /usr/libexec -name \*.la -delete

