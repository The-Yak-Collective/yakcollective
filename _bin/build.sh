#!/usr/bin/env bash

# NOTE: Any parameters passed to this script will be appended to the
# `jekyll` build command.

# Check to make sure that we're running in the repository root.
#
if [[ ! -f _config.yml || ! -d _bin ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Run init, if necessary.
#
if [[ ! -f .common-init ]]; then
	chmod +x _bin/common-init.sh
	./_bin/common-init.sh
fi

# Clean destination directory.
#
[[ -d _site ]] && rm --recursive --force _site

# Build site.
#
bundle exec jekyll build --profile

# Make all URLs relative (required for most web3 hosting solutions).
#
(
	cd _site
	../node_modules/.bin/all-relative
)

# Replace the __SITE_BASE_URL__ with one supplied on the command line
# as $1, or https://yakcollective.org.
#
SITE_BASE_URL="https://yakcollective.org"
if [[ -n "$1" ]]; then
	SITE_BASE_URL="$1"
fi
find _site -type f \( -iname '*.html'  -o -iname '*.xml'  -o -iname '*.json' -o -iname '*.js' -o -iname '*.css' \) -exec sed -i -e "s|__SITE_BASE_URL__|$SITE_BASE_URL|g" "{}" \;

# Revert escaped HTML characters that are needed to prevent Jekyll
# from barfing, but then cause minify (below) to barf. Sheesh.
#
find _site -type f -iname '*.html' -exec sed -i -e 's/&#x007b;/{/g;s/&#x007d;/}/g' "{}" \;

# Minify: https://github.com/tdewolff/minify
#
# Current version: 2.12.4 (last checked 2022-10-16)
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
MINIFY_BINARY="minify-$(uname -s | tr "[:upper:]" "[:lower:]")-$(uname -m)"
if [[ -f _bin/"$MINIFY_BINARY" ]]; then
	chmod +x _bin/"$MINIFY_BINARY"
	mv _site _site.original
	(
		cd _site.original
		../_bin/"$MINIFY_BINARY" --all --recursive --sync --output ../_site .
	)
	rm -rf _site.original
fi
