#!/usr/bin/env bash

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
mkdir -p .automation/var/cache/templates

if [[ -f newsletter.md ]]; then
	if [[ $(grep -c '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' newsletter.md) -eq 1 ]]; then
		sed '/<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->/,$d' newsletter.md > .automation/var/cache/templates/newsletter.md
		echo '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' >> .automation/var/cache/templates/newsletter.md
	fi
fi

if [[ -f writings.md ]]; then
	if [[ $(grep -c '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' newsletter.md) -eq 1 ]]; then
		sed '/<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->/,$d' writings.md > .automation/var/cache/templates/writings.md
		echo '<!-- DO NOT REMOVE THIS LINE! DO NOT EDIT BELOW THIS LINE! -->' >> .automation/var/cache/templates/writings.md
	fi
fi

# Update newsletter.md from Planet Pluto SQLite cache.
#

# Update writings.md from Planet Pluto SQLite cache.
#

echo "Some day I will be a beautiful script that will do wonderful things!"
