#!/usr/bin/env bash

# NOTE: Any parameters passed to this script will be appended to the
# `jekyll` build command.

# Check to make sure that we're running in the repository root.
#
if [[ ! -f _config.yml || ! -d bin ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Clean destination directory.
#
[[ -d _site ]] && rm --recursive --force _site

# Pull Knack data.
#
chmod +x bin/knack-pull-yaks.sh
./bin/knack-pull-yaks.sh || exit 1

# If we're running from Netlify, then all Ruby Gem setup has already
# been done for us. We assume that this is the case if the `jekyll`
# binary is in our path.
#
# Otherwise, use `bundle` to make sure that everything is installed
# and run the build.
#
if [[ -n "$(which jekyll)" ]]; then
	jekyll build --profile $@ || exit 4
elif [[ -n "$(which bundle)" ]]; then
	bundle config set path vendor/bundle || exit 2
	bundle install || exit 3
	bundle exec jekyll build --profile $@ || exit 4
else
	echo "Cannot find Bundler, and Jekyll does not seem to be installed."
	exit 1
fi

# Revert escaped HTML characters that are needed to prevent Jekyll
# from barfing, but then cause minify (below) to barf. Sheesh.
#
find _site -type f -iname '*.html' -exec sed -i -e 's/&#x007b;/{/g;s/&#x007d;/}/g' "{}" \;

# Minify: https://github.com/tdewolff/minify
#
# Current version: 2.9.22 (last checked 2021-11-14)
#
# It's too bad we need to cart this binary around as part of the repo,
# but Netlify doesn't support installing our own tools (otherwise we'd
# just `apt install minify`).
#
#     https://www.netlify.com/blog/2016/10/18/how-our-build-bots-build-sites/
#
# Note that sometimes `minify` will fail on a file, but when it does it
# simply leaves it untouched. We therefore return "true" at the end of
# the process in order to prevent Netlify from seeing this as a bad
# build.
#
# WARNING! Running `minify` AND Netlify's built-in optimization tends to
# result in invalid HTML/CSS/JS output! Netlify optimization should
# therefore be turned off when "hand optimization" like this is used.
#
chmod +x bin/minify
./bin/minify --recursive --output _site _site || true
