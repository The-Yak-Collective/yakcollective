#!/usr/bin/env bash

echo "[$(date)] Started Planet Pluto list updates"

# Source init.
#
if [[ -f ./.automation/bin/common-init.sh ]]; then
	source ./.automation/bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Make sure that RSS feeds have been pulled.
#
if [[ ! -f ./.automation/var/lib/pluto/newsletter.db ]] || [[ ! -f ./.automation/var/lib/pluto/writings.db ]]; then
	source ./.automation/bin/rss-pull-feeds.sh
fi

# Update markdown file cache, iff source files are usable.
#
# Sed trick from:
#
#     https://stackoverflow.com/questions/45125826/delete-everything-after-a-certain-line-in-bash/69868184#69868184
#
echo "[$(date)] Updating templates..."

mkdir -p .automation/var/cache/templates

if [[ -f Newsletter.md ]]; then
	if [[ $(grep -c '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' Newsletter.md) -eq 1 ]]; then
		sed '/<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->/,$d' Newsletter.md > .automation/var/cache/templates/Newsletter.md
		echo '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' >> .automation/var/cache/templates/Newsletter.md
	fi
fi

if [[ -f Writings.md ]]; then
	if [[ $(grep -c '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' Newsletter.md) -eq 1 ]]; then
		sed '/<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->/,$d' Writings.md > .automation/var/cache/templates/Writings.md
		echo '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' >> .automation/var/cache/templates/Writings.md
	fi
fi

# Update Newsletter.md from Planet Pluto SQLite cache.
#
echo "[$(date)] Updating Newsletter.md..."

DB=".automation/var/lib/pluto/newsletter.db"
MIN_YEAR="$(sqlite3 $DB "SELECT STRFTIME('%Y', MIN(published)) FROM items;")"
MAX_YEAR="$(sqlite3 $DB "SELECT STRFTIME('%Y', MAX(published)) FROM items;")"

cat .automation/var/cache/templates/Newsletter.md > Newsletter.md
for YEAR in $(seq $MAX_YEAR -1 $MIN_YEAR); do
	POST_COUNT="$(sqlite3 $DB "SELECT COUNT(*) FROM items WHERE STRFTIME('%Y', published) = '$YEAR';")"

	if [[ $POST_COUNT -gt 0 ]]; then
		echo "" >> Newsletter.md
		echo "## $YEAR" >> Newsletter.md

		sqlite3 $DB "SELECT '**\`' || STRFTIME('%d', published) || ' month' || STRFTIME('%m', published) || ':\`** *[' || REPLACE(REPLACE(title, '[', '\['), ']', '\]') || '](' || REPLACE(REPLACE(url, '(', '%28'), ')', '%29') || ')*  ' FROM items WHERE STRFTIME('%Y', published) = '$YEAR' ORDER BY published DESC;" | sed 's/month01/Jan/;s/month02/Feb/;s/month03/Mar/;s/month04/Apr/;s/month05/May/;s/month06/Jun/;s/month07/Jul/;s/month08/Aug/;s/month09/Sep/;s/month10/Oct/;s/month11/Nov/;s/month12/Dec/' >> Newsletter.md
	fi
done

sed 's/<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->/- TOC style seed\n{:toc}/' Newsletter.md > .automation/var/cache/build/Newsletter.md

# Update Writings.md from Planet Pluto SQLite cache.
#
echo "[$(date)] Updating Writings.md..."

DB=".automation/var/lib/pluto/writings.db"
MIN_YEAR="$(sqlite3 $DB "SELECT STRFTIME('%Y', MIN(published)) FROM items;")"
MAX_YEAR="$(sqlite3 $DB "SELECT STRFTIME('%Y', MAX(published)) FROM items;")"

cat .automation/var/cache/templates/Writings.md > Writings.md
for YEAR in $(seq $MAX_YEAR -1 $MIN_YEAR); do
	POST_COUNT="$(sqlite3 $DB "SELECT COUNT(*) FROM items WHERE STRFTIME('%Y', published) = '$YEAR';")"

	if [[ $POST_COUNT -gt 0 ]]; then
		echo "" >> Writings.md
		echo "## $YEAR" >> Writings.md

		FIRST_MONTH="yes"

		for MONTH_INT in $(seq 12 -1 1); do
			case $MONTH_INT in
				1)
					MONTH_NAME="January"
					MONTH="01"
					;;
				2)
					MONTH_NAME="February"
					MONTH="02"
					;;
				3)
					MONTH_NAME="March"
					MONTH="03"
					;;
				4)
					MONTH_NAME="April"
					MONTH="04"
					;;
				5)
					MONTH_NAME="May"
					MONTH="05"
					;;
				6)
					MONTH_NAME="June"
					MONTH="06"
					;;
				7)
					MONTH_NAME="July"
					MONTH="07"
					;;
				8)
					MONTH_NAME="August"
					MONTH="08"
					;;
				9)
					MONTH_NAME="September"
					MONTH="09"
					;;
				10)
					MONTH_NAME="October"
					MONTH="10"
					;;
				11)
					MONTH_NAME="November"
					MONTH="11"
					;;
				12)
					MONTH_NAME="December"
					MONTH="12"
					;;
				*)
					MONTH_NAME="Huh?"
					MONTH="00"
					;;
			esac

			POST_COUNT="$(sqlite3 $DB "SELECT COUNT(*) FROM items WHERE STRFTIME('%Y', published) = '$YEAR' AND STRFTIME('%m', published) = '$MONTH';")"

			if [[ $POST_COUNT -gt 0 ]]; then
				if [[ "$FIRST_MONTH" == "no" ]]; then
					echo "" >> Writings.md
				fi
				echo "### $MONTH_NAME" >> Writings.md

				FIRST_MONTH="no"

				sqlite3 $DB "SELECT '**\`' || STRFTIME('%d', items.published) || ' month' || STRFTIME('%m', items.published) || ':\`** [name' || feeds.key || '](/members/' || feeds.key || '.html), *[' || REPLACE(REPLACE(items.title, '[', '\['), ']', '\]') || '](' || REPLACE(REPLACE(items.url, '(', '%28'), ')', '%29') || ')*  ' FROM items JOIN feeds ON feeds.id = items.feed_id WHERE STRFTIME('%Y', items.published) = '$YEAR' AND STRFTIME('%m', items.published) = '$MONTH' ORDER BY items.published DESC;" | sed 's/month01/Jan/;s/month02/Feb/;s/month03/Mar/;s/month04/Apr/;s/month05/May/;s/month06/Jun/;s/month07/Jul/;s/month08/Aug/;s/month09/Sep/;s/month10/Oct/;s/month11/Nov/;s/month12/Dec/' >> Writings.md
			fi
		done
	fi
done

while read -r RECORD; do
	MEMBER_ID="$(echo "$RECORD" | cut -f 1)"
	NAME="$(echo "$RECORD" | cut -s -f 2 | sed -e 's#|#/#g')"
	if [[ -n "$NAME" ]]; then
		sed -i -e "s|name$MEMBER_ID|$NAME|" Writings.md
	else
		sed -i -e "s|name$MEMBER_ID|Anonymous Contributor #$MEMBER_ID|" Writings.md
	fi
done < <(jq -r '.records[] | [.field_101_raw, .field_97_raw?] | @tsv' .automation/var/cache/build/_data/knack_yaks.json | sed -e 's/^\s*//;s/\s*$//')

sed 's/<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->/- TOC style seed\n{:toc}/' Writings.md > .automation/var/cache/build/Writings.md

# Generate writings.xml from Planet Pluto SQLite cache.
#
echo "[$(date)] Creating writings.xml..."

DB=".automation/var/lib/pluto/writings.db"

cat > .automation/var/cache/build/writings.xml << EOF
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/">
	<channel>
		<title>Yak Collective Member Writings</title>
		<description>Yak Collective member posts from around the Web.</description>
		<sy:updatePeriod>daily</sy:updatePeriod>
		<sy:updateFrequency>1</sy:updateFrequency>
		<link>https://yakcollective.org/writings.html</link>
		<atom:link href="https://yakcollective.org/writings.xml" rel="self" type="application/rss+xml" />
		<lastBuildDate>$(date --date="$(sqlite3 .automation/var/lib/pluto/writings.db "SELECT MAX(published) FROM items;")" "+%a, %d %b %Y %H:%M:%S %z")</lastBuildDate>
EOF

while read -r RECORD; do
	PLUTO_ID="$(echo "$RECORD" | cut -d "|" -f 1)"
	PUB_DATE="$(date --date="$(echo "$RECORD" | cut -d "|" -f 2)" "+%a, %d %b %Y %H:%M:%S %z")"
	RSS_LINK="$(sqlite3 $DB "SELECT url FROM items WHERE id = $PLUTO_ID" | sed 's/&/\&amp;/g')"

	cat >> .automation/var/cache/build/writings.xml << EOF
	<item>
		<title>$(sqlite3 $DB "SELECT title FROM items WHERE id = $PLUTO_ID" | sed 's/&/\&amp;/g;s/</\&lt;/g;s/>/\&gt;/g')</title>
		<description>$(sqlite3 $DB "SELECT content FROM items WHERE id = $PLUTO_ID" | sed 's/&/\&amp;/g;s/</\&lt;/g;s/>/\&gt;/g')</description>
		<pubDate>$PUB_DATE</pubDate>
		<link>$RSS_LINK</link>
		<guid isPermaLink="true">$RSS_LINK</guid>
	</item>
EOF
done < <(sqlite3 $DB "SELECT id, published FROM items ORDER BY published, id DESC")

cat >> .automation/var/cache/build/writings.xml << EOF
	</channel>
</rss>
EOF

echo "[$(date)] Finished Planet Pluto list updates"
