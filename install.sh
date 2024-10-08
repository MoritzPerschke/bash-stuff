#! /bin/bash

target="$HOME/.local/bin/"
this=$(basename "$0")

for file in *.sh; do
	if [ "$file" = "$this" ] || [ ! -f "$file" ]; then
		continue
	fi

	link="${file%.sh}"
	sudo chmod +x $file
	echo ln -s "$(pwd)/$file" "$target$link"
done
