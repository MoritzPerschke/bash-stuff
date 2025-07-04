#! /bin/bash

# where to link the scripts to, this should be in path
this="$(realpath "$0")"
target="$HOME/.local/bin/"

echo "Linking bash scripts"
# Check once if target dir exists
if [[ ! -d "$target" ]]; then
    echo "$target not found"
else
    for file in ./scripts/*.sh; do
	# Skip if it's this script or not a regular file
	[[ "$(realpath "$file")" == "$this" || ! -f "$file" ]] && continue

	linkname="$(basename "${file%.sh}")"   # Strip .sh and get name
	chmod +x "$file"                       # Make it executable
	ln -sf "$(realpath "$file")" "$target/$linkname"
    done
fi

if ! [ -d ~/.bashrc.d ]; then
	echo "~/.bashrc.d not found, creating..."
	mkdir ~/.bashrc.d
fi

echo "Linking config files"
ln -sf "$(pwd)/bashrc.d/functions" "$HOME/.bashrc.d/functions"
ln -sf "$(pwd)/bashrc.d/aliases" "$HOME/.bashrc.d/aliases"
ln -sf "$(pwd)/bashrc.d/bashconfig" "$HOME/.bashrc.d/bashconfig"
ln -sf "$(pwd)/bashrc.d/gitconfig" "$HOME/.gitconfig"

echo "appending to ~/.bashrc"
# echo -e "\nif [ -d ~/.bashrc.d ]; then\n\t. ~/.bash_custom\nfi" | tee -a ~/.bashrc
# https://stackoverflow.com/questions/4990172/how-to-append-several-lines-of-text-in-a-file-using-a-shell-script
cat <<'EOF' >> ~/.bashrc

# Custom bash stuff, installed through install.sh from:
# https://github.com/MoritzPerschke/bash-stuff
if [ -d ~/.bashrc.d ]; then
	for f in ~/.bashrc.d/*; do
		. $f
	done
fi
EOF
