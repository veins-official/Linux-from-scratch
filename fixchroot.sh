rm -rf $COLD/{lib,bin,sbin}

for i in bin lib sbin; do
	ln -sv usr/$i $COLD/$i;
done
ln -sv bash $COLD/bin/sh

