#!/usr/bin/env bash

CMD=cp
TARGETDIR=""
FUN=backup

usage() {
	echo "Usage: $0 [OPTION] FILES
Options:
	-m  'mv' the files instead of copying
	-t  set /tmp as target
	-d  specify target directory
	-r  'recover' target files (foo.c.bkp -> foo.c)
	"
}

recover() {
	for file in "$@"; do
		STRIPPED="$(basename $file .bkp)"
		echo "$CMD $file -> $TARGETDIR$STRIPPED"
		$CMD $file $TARGETDIR$STRIPPED
	done
}

backup() {
	for file in "$@"; do
		echo "$CMD $file -> $TARGETDIR$file.bkp"
		$CMD $file "$TARGETDIR$file.bkp"
	done
}

while getopts mtd:rh opt; do
	case "$opt" in
		m)
			CMD=mv
			;;
		t)
			TARGETDIR=/tmp/
			;;
		d)
			TARGETDIR="${OPTARG%/}"/
			;;
		r)
			FUN=recover
			;;
		h)
			usage
			;;
		*)
			usage
			;;
	esac
done

$FUN "${@:$OPTIND}"
