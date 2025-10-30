./configure --prefix=/usr --host=$COLD_TGT \
&& make \
&& make DESTDIR=$COLD install

