CHAPTER="$1"
PACKAGE="$2"

cat packages.csv | grep -i "^$PACKAGE;" | grep -i -v "\.patch;" | while read line; do
	export VERSION="`echo $line | cut -d\; -f2`"
	URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
	CACHEFILE="$(basename "$URL")"
	DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')"
	
	if [ -d "$DIRNAME" ]; then
		rm -rf "$DIRNAME"
	fi
	mkdir -pv "$DIRNAME"
	
	echo "Extracting $CACHEFILE"
	if [ "$(tar -tf "$CACHEFILE" | awk -F/ '{print $1}' | sort -u | wc -l)" -eq 1 ]; then
		tar -xf "$CACHEFILE" -C "$DIRNAME" --strip-components=1
	else
		tar -xf "$CACHEFILE" -C "$DIRNAME"
	fi
	
	pushd "$DIRNAME"
	
	echo "Compiling $PACKAGE"
	sleep 5
	
	mkdir -pv "../log/chapter$CHAPTER/"
	
	if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log"; then
		echo "Compiling $PACKAGE FAILED!"
		popd
		exit 1
	fi
	
	echo "Done compiling $PACKAGE"
	
	popd
done

