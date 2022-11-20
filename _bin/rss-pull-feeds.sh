#!/usr/bin/env bash

# Source init.
#
if [[ -f ./_bin/common-init.sh ]]; then
	source ./_bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Generate ini file for the "writings" page.
#
echo "title = \"The Yak Collective's Writings\"" > _pluto/writings.ini
echo "" >> _pluto/writings.ini

while IFS= read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	RSS_FEED="$(echo "$RECORD" | cut -s -f 2)"
	if [[ -n "$RSS_FEED" ]]; then
		echo "[$MEMBER_ID]" >> _pluto/writings.ini
		echo -e "\tfeed = $RSS_FEED" >> _pluto/writings.ini
		echo "" >> _pluto/writings.ini
	fi
done <<< "$(jq -r '.records[] | [.field_101_raw, .field_68_raw.url?] | @tsv' _data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')"

# Pull down RSS feeds.
#
(
	cd _pluto
	chmod +x build-posts.rb

	bundle exec pluto update newsletter.ini
	bundle exec build-posts.rb newsletter

	bundle exec pluto update writings.ini
	bundle exec build-posts.rb writings
)

# Integrate Discord posts.
#
mv _pluto/discord/* _discord/

# Integrate newsletter posts.
#
mv _pluto/newsletter/* newsletter/_posts/

sed -i 's#http://a9\.io/glue-comic/#https://a9.io/glue-comic/#g' newsletter/_posts/2020-09-04-podcasting-needs-cognitive-hooks.html

# Integrate Twitter posts.
#
mv _pluto/twitter/* _twitter/

# Integrate writings.
#
mv _pluto/writings/* writings/_posts/

# Script run indicator.
#
date "+%s" > _pluto/.last-run
