#! /bin/bash

# where to link the scripts to, this should be in path
target="$HOME/.local/bin/"
this=$(basename "$0")

for file in *.sh; do
	if [ "$file" = "$this" ] || [ ! -f "$file" ]; then
		continue
	fi

	link="${file%.sh}"
	sudo chmod +x $file
	ln -s "$(pwd)/$file" "$target$link"
done

if ! [ -d ~/.bashrc.d ]; then
	mkdir ~/.bashrc.d
fi
ln -sf "$(pwd)/bashrc.d/functions" "$HOME/.bashrc.d/functions"
ln -sf "$(pwd)/bashrc.d/aliases" "$HOME/.bashrc.d/aliases"
ln -sf "$(pwd)/bashrc.d/gitconfig" "$HOME/.gitconfig"

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
