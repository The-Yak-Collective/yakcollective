#!/usr/bin/env bash

# Source init.
#
if [[ -f ./_bin/common-init.sh ]]; then
	source ./_bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Double-check path.
#
if [[ ! -f ./css/_fonts.css ]]; then
	echo "This script must be run in the project root!"
fi

# Clean font directory.
#
[[ -d ./fonts/google ]] && rm -rf ./fonts/google
mkdir -p ./fonts/google

# Create unified CSS file.
#
cat ./css/_fonts.css | sed -e 's#url(https.*/#url(/fonts/google/#' > ./css/fonts.css

# Download fonts.
#
(
	cd ./fonts/google
	for WOFF in $(cat ../../css/_fonts.css | sed -e 's/^.*src:.*url(//;/^\s.*/d;/^[^h].*/d;s/).*//' | xargs); do
		curl -sS -L -O $WOFF
	done
)
