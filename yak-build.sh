#!/usr/bin/env bash

bundle install
./yak-make-ini.rb > yak-planet.ini
bundle exec pluto update yak-planet.ini
./yak-make-posts.rb
find _posts -type f -iname '*.html' -exec sed -i -e 's/{/\&#x007B;/g;s/}/\&#x007D;/g;s/%/\&#x0023;/g' "{}" \;

if [[ "$1" == "serve" ]]; then
	bundle exec jekyll serve
else
	bundle exec jekyll build
fi
