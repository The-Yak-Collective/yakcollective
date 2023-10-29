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
echo "title = \"The Yak Collective's Writings\"" > .automation/var/pluto/writings.ini
echo "" >> .automation/var/pluto/writings.ini

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	RSS_FEED="$(echo "$RECORD" | cut -s -f 2)"
	if [[ -n "$RSS_FEED" ]]; then
		echo "[$MEMBER_ID]" >> .automation/var/pluto/writings.ini
		echo -e "\tfeed = $RSS_FEED" >> .automation/var/pluto/writings.ini
		echo "" >> .automation/var/pluto/writings.ini
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_68_raw.url?] | @tsv' .automation/var/cache/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

# Pull down RSS feeds.
#
(
	cd .automation/var/pluto
	chmod +x ../../bin/build-posts.rb

	export BUNDLE_USER_CONFIG=../cache/.bundle/config

	bundle exec pluto update newsletter.ini
	bundle exec ../../bin/build-posts.rb newsletter

	bundle exec pluto update writings.ini
	bundle exec ../../bin/build-posts.rb writings
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
		mv -v "$FILE" .automation/var/feeds/bluesky/
	else
		rm "$FILE"
	fi
done < <(find .automation/var/pluto/bluesky -type f -iname '*.txt')

echo "Fixing Bluesky handles..."

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	BLUESKY_HANDLE="$(echo "$RECORD" | cut -s -f 2| sed -e 's#.*/##;s#@##;s/#//g')"
	if [[ -n "$BLUESKY_HANDLE" ]]; then
		while read -r FILE; do
			sed -i -e "s#@$MEMBER_ID#@$BLUESKY_HANDLE#" "$FILE"
		done < <(find .automation/var/feeds/bluesky -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_108_raw?] | @tsv' .automation/var/cache/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#|#/#g')"
	if [[ -n "$NAME" ]]; then
		while read -r FILE; do
			sed -i -e "s|@$MEMBER_ID|$NAME|" "$FILE"
		done < <(find .automation/var/feeds/bluesky -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_97_raw?] | @tsv' .automation/var/cache/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

# Integrate new Farcaster posts.
#
echo "Setting up new Farcaster posts..."

while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		mv -v "$FILE" .automation/var/feeds/farcaster/
	else
		rm "$FILE"
	fi
done < <(find .automation/var/pluto/farcaster -type f -iname '*.txt')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	FARCASTER_HANDLE="$(echo "$RECORD" | cut -s -f 2| sed -e 's#.*/##;s#@##;s/#//g')"
	if [[ -n "$FARCASTER_HANDLE" ]]; then
		while read -r FILE; do
			sed -i -e "s#@$MEMBER_ID#@$FARCASTER_HANDLE#" "$FILE"
		done < <(find .automation/var/feeds/farcaster -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_109_raw?] | @tsv' .automation/var/cache/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#|#/#g')"
	if [[ -n "$NAME" ]]; then
		while read -r FILE; do
			sed -i -e "s|@$MEMBER_ID|$NAME|" "$FILE"
		done < <(find .automation/var/feeds/farcaster -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_97_raw?] | @tsv' .automation/var/cache/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

# Integrate new Discord posts.
#
echo "Setting up new Discord posts..."

while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		mv -v "$FILE" .automation/var/feeds/discord/
	else
		rm "$FILE"
	fi
done < <(find .automation/var/pluto/discord -type f -iname '*.txt')

# Integrate new Twitter posts.
#
echo "Setting up new Twitter posts..."

while read -r FILE; do
	DATE="$(basename ${FILE%%-*})"
	if [[ $DATE -ge $LAST_RUN ]]; then
		mv -v "$FILE" .automation/var/feeds/twitter/
	else
		rm "$FILE"
	fi
done < <(find .automation/var/pluto/twitter -type f -iname '*.txt')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	TWITTER_HANDLE="$(echo "$RECORD" | cut -s -f 2| sed -e 's#.*/##;s#@##;s/#//g')"
	if [[ -n "$TWITTER_HANDLE" ]]; then
		while read -r FILE; do
			sed -i -e "s#@$MEMBER_ID#@$TWITTER_HANDLE#" "$FILE"
		done < <(find .automation/var/feeds/twitter -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_43_raw?] | @tsv' .automation/var/cache/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#|#/#g')"
	if [[ -n "$NAME" ]]; then
		while read -r FILE; do
			sed -i -e "s|@$MEMBER_ID|$NAME|" "$FILE"
		done < <(find .automation/var/feeds/twitter -type f -iname '*.txt' -exec grep -l "@$MEMBER_ID" "{}" \;)
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_97_raw?] | @tsv' .automation/var/cache/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

# Integrate new newsletters.
#
cp -f .automation/var/pluto/newsletter/* newsletter/_posts/
cp -f .automation/var/pluto/newsletter/* .automation/var/cache/newsletter/_posts/

# Integrate new writings.
#
cp -f .automation/var/pluto/writings/* writings/_posts/
cp -f .automation/var/pluto/writings/* .automation/var/cache/writings/_posts/

# Script run indicator.
#
date "+%s" > .automation/var/state/pluto
