#!/bin/bash -i
# get command before this scripts shebang and invocation of script
last_command=$(fc -ln -5 -5 | sed 's/^[ \t]*//')
s_flag=false
S_flag=false
delete_original=false

# Parse options 
while getopts ":s:S:hd" opt; do
	case $opt in
		s)
			s_flag=true
			script_name="$OPTARG"
			;;
		S)
			S_flag=true
			s_flag=true
			script_name="$OPTARG"
			;;
		h)
			echo "getlast help:"
			echo -e "\t-s <filename> append last command and create an executable script from given or default shorthist file"
			echo -e "\t-S <filename> don'\''t append last command and create an executable script from given or default shorthist file"
			echo -e "\t-d delete shorthist file"
			exit 0
			;;
		d)
			delete_original=true
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
		:)
			echo "Option -$OPTARG requires an argument" >&2
			exit 1
			;;
	esac
done

shift $((OPTIND - 1))
# Set filename to first argument if exists
if [[ -n "$1" ]]; then
	output_file="$1"
else
	output_file='shorthist.txt'
fi

# Write the last command to file
if [[ ! "$S_flag" = true ]]; then
	echo "$last_command >> $output_file"
	echo "$last_command" >> "$output_file"
fi

# If -s option is set, turn existing file into script,
# otherwise just append to file
if [[ "$s_flag" = true || "$S_flag" = true ]]; then
	# Check script name provided
	if [[ -z "$script_name" ]]; then
		echo 'No file for output script provided. Use -s <script_name> to specify.'
		exit 1
	fi

	# Create script file
	echo '#!/bin/bash' >> "$script_name"

	# Dump histfile into script
	cat "$output_file" >> "$script_name"

	# Set permissions
	chmod 755 "$script_name"

	echo "Script $script_name created from $output_file."
fi

if [[ "$delete_original" = true ]]; then
	rm "$output_file"
fi
