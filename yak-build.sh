#!/usr/bin/env bash

bundle install
./yak-make-ini.rb > yak-planet.ini
bundle exec pluto update yak-planet.ini
./yak-make-posts.rb
bundle exec jekyll build
