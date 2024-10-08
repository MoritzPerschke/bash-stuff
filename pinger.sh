#! /bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

input=$HOME/.ping_urls.txt

while IFS= read -r url; do
	echo -n ""
	status_code=$(curl --connect-timeout 5 -s -o /dev/null -I -w "%{http_code}" "$url")
	first_digit=${status_code:0:1}

	case $first_digit in
		2)
			echo -e "$url Status: ${GREEN}$status_code${NC}"
			;;
		3)
			echo -e "$url Status: ${YELLOW}$status_code${NC}"
			;;
		4)
			echo -e "$url Status: ${RED}$status_code${NC}"
			;;
		5)
			echo -e "$url Status: ${RED}$status_code${NC}"
			;;
		*)
			echo -e "$url Status: ${RED}None${NC}"
			;;

	esac
done < "$input"
