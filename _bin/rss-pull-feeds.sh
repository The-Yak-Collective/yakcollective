#!/usr/bin/env bash

# Install pre-requisits.
#
[[ -z "$(which bundle)" ]] && gem install bundler

bundle config set path vendor/bundle
bundle install

# Pull Knack data.
#
chmod +x _bin/knack-pull-yaks.sh
./_bin/knack-pull-yaks.sh

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
	chmod +x *.rb
	bundle exec pluto update newsletter.ini
	bundle exec build-posts.rb newsletter
	mv newsletter/* ../newsletter/_posts/
	bundle exec pluto update writings.ini
	bundle exec build-posts.rb writings
	mv writings/* ../writings/_posts/
)

# One-off fixes.
#
sed -i 's#http://a9\.io/glue-comic/#https://a9.io/glue-comic/#g' newsletter/_posts/2020-09-04-podcasting-needs-cognitive-hooks.html

# Set script timer.
#
date "+%s" > _timers/rss-pull-feeds
