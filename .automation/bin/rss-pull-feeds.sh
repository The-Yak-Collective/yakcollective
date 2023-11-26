#!/usr/bin/env bash

# Source init.
#
if [[ -f ./.automation/bin/common-init.sh ]]; then
	source ./.automation/bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Generate ini file for the "writings" page.
#
echo "title = \"The Yak Collective's Writings\"" > .automation/var/lib/pluto/writings.ini
echo "" >> .automation/var/lib/pluto/writings.ini

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	RSS_FEED="$(echo "$RECORD" | cut -s -f 2)"
	if [[ -n "$RSS_FEED" ]]; then
		echo "[$MEMBER_ID]" >> .automation/var/lib/pluto/writings.ini
		echo -e "\tfeed = $RSS_FEED" >> .automation/var/lib/pluto/writings.ini
		echo "" >> .automation/var/lib/pluto/writings.ini
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_68_raw.url?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

# Pull down RSS feeds.
#
(
	cd .automation/var/lib/pluto
	chmod +x ../../../bin/build-posts.rb

	export BUNDLE_GEMFILE=../../cache/build/Gemfile
	export BUNDLE_USER_CONFIG=../../cache/build/.bundle/config

	bundle exec pluto update newsletter.ini
	bundle exec ruby ../../../bin/build-posts.rb newsletter

	bundle exec pluto update writings.ini
	bundle exec ruby ../../../bin/build-posts.rb writings
)

# Pull last run timestamp.
#
if [[ -f .automation/var/state/pluto ]]; then
	LAST_RUN="$(cat .automation/var/state/pluto)"
else
	LAST_RUN=0
fi

# Integrate new Bluesky posts.
#
echo "Setting up new Bluesky posts..."

while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		cp -v "$FILE" .automation/var/spool/bluesky/
	fi
done < <(find .automation/var/lib/pluto/bluesky -type f -iname '*.txt')

echo "Fixing Bluesky handles..."

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	BLUESKY_HANDLE="$(echo "$RECORD" | cut -s -f 2| sed -e 's#.*/##;s#@##;s/#//g')"
	if [[ -n "$BLUESKY_HANDLE" ]]; then
		while read -r FILE; do
			sed -i -e "s#@$MEMBER_ID#@$BLUESKY_HANDLE#" "$FILE"
		done < <(find .automation/var/spool/bluesky -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_108_raw?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#|#/#g')"
	if [[ -n "$NAME" ]]; then
		while read -r FILE; do
			sed -i -e "s|@$MEMBER_ID|$NAME|" "$FILE"
		done < <(find .automation/var/spool/bluesky -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_97_raw?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//;s/([^()]\+)//g;s/@.*//;s/ \+/ /g')

# Integrate new Farcaster posts.
#
echo "Setting up new Farcaster posts..."

while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		cp -v "$FILE" .automation/var/spool/farcaster/
	fi
done < <(find .automation/var/lib/pluto/farcaster -type f -iname '*.txt')

echo "Fixing Farcaster handles..."

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	FARCASTER_HANDLE="$(echo "$RECORD" | cut -s -f 2| sed -e 's#.*/##;s#@##;s/#//g')"
	if [[ -n "$FARCASTER_HANDLE" ]]; then
		while read -r FILE; do
			sed -i -e "s#@$MEMBER_ID#@$FARCASTER_HANDLE#" "$FILE"
		done < <(find .automation/var/spool/farcaster -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_109_raw?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#|#/#g')"
	if [[ -n "$NAME" ]]; then
		while read -r FILE; do
			sed -i -e "s|@$MEMBER_ID|$NAME|" "$FILE"
		done < <(find .automation/var/spool/farcaster -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_97_raw?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//;s/([^()]\+)//g;s/@.*//;s/ \+/ /g')

# Integrate new Discord posts.
#
echo "Setting up new Discord posts..."

while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		cp -v "$FILE" .automation/var/spool/discord/
	fi
done < <(find .automation/var/lib/pluto/discord -type f -iname '*.txt')

# Integrate new Twitter posts.
#
echo "Setting up new Twitter posts..."

while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		cp -v "$FILE" .automation/var/spool/twitter/
	fi
done < <(find .automation/var/lib/pluto/twitter -type f -iname '*.txt')

echo "Fixing Twitter handles..."

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	TWITTER_HANDLE="$(echo "$RECORD" | cut -s -f 2| sed -e 's#.*/##;s#@##;s/#//g')"
	if [[ -n "$TWITTER_HANDLE" ]]; then
		while read -r FILE; do
			sed -i -e "s#@$MEMBER_ID#@$TWITTER_HANDLE#" "$FILE"
		done < <(find .automation/var/spool/twitter -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_43_raw?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#|#/#g')"
	if [[ -n "$NAME" ]]; then
		while read -r FILE; do
			sed -i -e "s|@$MEMBER_ID|$NAME|" "$FILE"
		done < <(find .automation/var/spool/twitter -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_97_raw?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//;s/([^()]\+)//g;s/@.*//;s/ \+/ /g')

# Update newsletters and writings caches.
#
cp -f .automation/var/lib/pluto/newsletter/* .automation/var/cache/pluto/newsletter/
cp -f .automation/var/lib/pluto/writings/* .automation/var/cache/pluto/writings/

# Script run indicator.
#
date "+%s" > .automation/var/state/pluto
