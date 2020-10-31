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

# If we're running from Netlify, then all Ruby Gem setup has already
# been done for us. We assume that this is the case if the `jekyll`
# binary is in our path.
#
# Otherwise, use `bundle` to make sure that everything is installed
# and run the build.
#
if [[ -n "$(which jekyll)" ]]; then
	jekyll build --profile $@
elif [[ -n "$(which bundle)" ]]; then
	bundle config set path vendor/bundle
	bundle install
	bundle exec jekyll build --profile $@
else
	echo "Cannot find Bundler, and Jekyll does not seem to be installed."
	exit 1
fi

# Minify: https://github.com/tdewolff/minify
#
# Current version: 2.9.10 (last checked 2020-10-31)
#
# It's too bad we need to cart this binary around as part of the repo,
# but Netlify doesn't support installing our own tools (otherwise we'd
# just `apt install minify`).
#
#     https://www.netlify.com/blog/2016/10/18/how-our-build-bots-build-sites/
#
chmod +x bin/minify
./bin/minify --recursive --output _site _site
