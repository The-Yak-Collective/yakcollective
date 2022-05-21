#!/usr/bin/env bash

if [[ ! -f ./css/_fonts.css ]]; then
	echo "This script must be run in the project root!"
fi

[[ -d ./fonts/google ]] && rm -rf ./fonts/google
mkdir -p ./fonts/google
cat ./css/_fonts.css | sed -e 's#url(https.*/#url(/fonts/google/#' > ./css/fonts.css

(
	cd ./fonts/google
	for WOFF in $(cat ../../css/_fonts.css | sed -e 's/^.*src:.*url(//;/^\s.*/d;/^[^h].*/d;s/).*//' | xargs); do
		curl -sS -L -O $WOFF
	done
)
