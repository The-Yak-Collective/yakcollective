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
./bin/knack-pull-yaks.sh || exit 2

# If we're running from Netlify, then all Ruby Gem setup has already
# been done for us. We assume that this is the case if the `jekyll`
# binary is in our path.
#
# Otherwise, use `bundle` to make sure that everything is installed
# and run the build.
#
if [[ -n "$(which jekyll)" ]]; then
	jekyll build --profile || exit 4
elif [[ -n "$(which bundle)" ]]; then
	bundle config set path vendor/bundle || exit 8
	bundle install || exit 3
	bundle exec jekyll build --profile || exit 16
else
	echo "Cannot find Bundler, and Jekyll does not seem to be installed."
	exit 32
fi

# Make all URLs relative (required for most web3 hosting solutions).
#
#(
#	cd _site
#	npm exec --yes all-relative
#)

# Replace the __SITE_BASE_URL__ with one supplied on the command line
# as $1, or https://yakcollective.org.
#
SITE_BASE_URL="https://yakcollective.org"
if [[ -n "$1" ]]; then
	SITE_BASE_URL="$1"
fi
find _site -type f \( -iname '*.html'  -o -iname '*.xml'  -o -iname '*.json' -o -iname '*.js' -o -iname '*.css' \) -exec sed -i -e "s|__SITE_BASE_URL__|$SITE_BASE_URL|g" "{}" \;

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
mv _site _site.original
(
	cd _site.original
	../bin/minify --all --recursive --sync --output ../_site .
)
rm -rf _site.original
