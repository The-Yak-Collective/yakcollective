#!/usr/bin/env bash

rm -rf fonts
mkdir fonts
cat fonts-src.css | sed -e 's#url(https.*/#url(/assets/static/fonts/#' > fonts.css

(
	cd fonts
	for WOFF in $(cat ../fonts-src.css | sed -e 's/^.*src:.*url(//;/^\s.*/d;/^[^h].*/d;s/).*//' | xargs); do
		curl -L -O $WOFF
	done
)
