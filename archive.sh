#!/usr/bin/env bash

# set -e

ROOT_DIR="$(pwd)"
ARCHIVE_NAME="${1:-$(basename "$(pwd)").tar.gz}"

TOTAL=$(find "$ROOT_DIR" -type d | wc -l)
PROCESSED=0

echo "Preprocessing directories..."

find "$ROOT_DIR" -type d | while read -r dir; do
	((PROCESSED++))
	PERCENT=$((PROCESSED * 100 / TOTAL))

	printf "\r [-] Processing: %s ... (%3d%%)" "$dir" "$PERCENT"

	case "$(basename "$dir")" in
		.git)
			PARENT="${dir%/.git}"
			git -C "$PARENT" pull >/dev/null 2>&1 || { echo "Error: Git pull failed in $dir"; }
			;;
		env | build | target)
			rm -rf "$dir" || { echo "Error: Failed to delete $dir"; }
			;;
	esac
	tput el
done

echo -e "\nCreating archive $ARCHIVE_NAME"
tar -czf "$ARCHIVE_NAME" ./*
echo "Done"

