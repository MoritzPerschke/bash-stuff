#!/usr/bin/env bash

CMD=cp
TARGETDIR="$PWD/"
FUN=backup

usage() {
	echo "Usage: $0 [OPTION] FILES
Options:
	-m  'mv' the files instead of copying
	-t  set /tmp as target
	-d  specify target directory
	-r  'recover' target files (foo.c.bkp -> foo.c); *ALWAYS* uses mv
	"
}

recover() {

	[[ $1 == *.bkp ]] || { echo "refusing to recover file not ending in .bkp: '$1'" >&2; exit 1; }

	local STRIPPED="$(basename "$1" .bkp)"
	local DEST="$TARGETDIR$STRIPPED"
	if [[ -d $DEST ]]; then
		rm -r "$DEST" || exit 1
	fi

	echo "mv $1 -> $DEST"
	mv "$1" "$DEST"
}

backup() {
	local FILE=$1
	local DEST="$TARGETDIR$FILE"
	if [[ $CMD == "cp" && -d "$1" ]]; then
		local CMD="cp -r"
		DEST="${DEST%/}"
		
	fi

	echo "$CMD $FILE -> $DEST.bkp"
	$CMD "$FILE" "$DEST.bkp"
}

while getopts :mtd:rh opt; do
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

for file in "${@:$OPTIND}"; do
	$FUN "$file"
done
