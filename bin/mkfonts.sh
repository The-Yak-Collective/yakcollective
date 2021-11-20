#!/usr/bin/env bash

if [[ ! -f ./css/fonts.source.css ]]; then
	echo "This script must be run in the project root!"
fi

[[ -d ./fonts/google ]] && rm -rf ./fonts/google
mkdir -p ./fonts/google
cat ./css/fonts.source.css | sed -e 's#url(https.*/#url(/fonts/google/#' > ./css/fonts.css

(
	cd ./fonts/google
	for WOFF in $(cat ../../css/fonts.source.css | sed -e 's/^.*src:.*url(//;/^\s.*/d;/^[^h].*/d;s/).*//' | xargs); do
		curl -sS -L -O $WOFF
	done
)
