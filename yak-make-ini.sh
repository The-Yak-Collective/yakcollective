#!/usr/bin/env bash

echo "title = The Yak Collective"
echo ""

for MEMBER_FILE in ./members/_posts/*.md; do
	if [[ $(grep -c -E "^feed: " "$MEMBER_FILE") -eq 1 ]]; then
		MEMBER_UID="$(basename "$MEMBER_FILE" ".md" | sed -e 's/^....-..-..-//')"
		FEED_URL="$(grep -E "^feed: " "$MEMBER_FILE" | sed -e 's/^feed: //')"
		echo "[${MEMBER_UID}]"
		echo "title = $MEMBER_UID"
		echo "feed = $FEED_URL"
		echo ""
	fi
done
