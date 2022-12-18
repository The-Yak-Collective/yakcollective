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

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	RSS_FEED="$(echo "$RECORD" | cut -s -f 2)"
	if [[ -n "$RSS_FEED" ]]; then
		echo "[$MEMBER_ID]" >> _pluto/writings.ini
		echo -e "\tfeed = $RSS_FEED" >> _pluto/writings.ini
		echo "" >> _pluto/writings.ini
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_68_raw.url?] | @tsv' _data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

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

# Pull last run timestamp.
#
if [[ -f _pluto/.last-run ]]; then
	LAST_RUN="$(cat _pluto/.last-run)"
else
	LAST_RUN=0
fi

# Integrate new Discord posts.
#
while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		mv -v "$FILE" _discord/
	else
		rm "$FILE"
	fi
done < <(find _pluto/discord -type f -iname '*.txt')

# Integrate new Twitter posts.
#
while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		mv -v "$FILE" _twitter/
	else
		rm "$FILE"
	fi
done < <(find _pluto/twitter -type f -iname '*.txt')

# Fix Twitter usernames.
#
while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	TWITTER_HANDLE="$(echo "$RECORD" | cut -s -f 2| sed -e 's#.*/##;s#@##;s/#//g')"
	if [[ -n "$TWITTER_HANDLE" ]]; then
		while read -r FILE; do
			sed -i -e "s#@$MEMBER_ID#@$TWITTER_HANDLE#" "$FILE"
		done < <(find _twitter -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_43_raw?] | @tsv' _data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#|#/#g')"
	if [[ -n "$NAME" ]]; then
		while read -r FILE; do
			sed -i -e "s|@$MEMBER_ID|$NAME|" "$FILE"
		done < <(find _twitter -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_97_raw?] | @tsv' _data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

# Integrate new newsletters.
#
mv _pluto/newsletter/* newsletter/_posts/

# Integrate new writings.
#
mv _pluto/writings/* writings/_posts/

# Script run indicator.
#
date "+%s" > _pluto/.last-run
