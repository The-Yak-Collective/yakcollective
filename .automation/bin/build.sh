#!/usr/bin/env bash

# NOTE: Any parameters passed to this script will be appended to the
# `jekyll` build command.

# Source init.
#
if [[ -f ./.automation/bin/common-init.sh ]]; then
	source ./.automation/bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Make sure that lists have been generated.
#
if [[ ! -f .automation/var/cache/build/writings.xml ]]; then
	source ./.automation/bin/update-lists.sh
fi

# Everything that follows needs to happen in the automation cache
# directory.
#
(
	cd .automation/var/cache/build

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

	# Replace the __SITE_BASE_URL__ with one supplied on the command
	# line as $1, or https://yakcollective.org.
	#
	SITE_BASE_URL="https://yakcollective.org"
	if [[ -n "$1" ]]; then
		SITE_BASE_URL="$1"
	fi
	find _site -type f \( -iname '*.html'  -o -iname '*.xml'  -o -iname '*.json' -o -iname '*.js' -o -iname '*.css' \) -exec sed -i -e "s|__SITE_BASE_URL__|$SITE_BASE_URL|g" "{}" \;

	# Minify: https://github.com/tdewolff/minify
	#
	# It's too bad we need to cart this binary around as part of the
	# repo, but Netlify doesn't support installing our own tools
	# (otherwise we'd just `apt install minify`).
	#
	#     https://www.netlify.com/blog/2016/10/18/how-our-build-bots-build-sites/
	#
	# Note that sometimes `minify` will fail on a file, but when it does
	# it simply leaves it untouched. We therefore return "true" at the
	# end of the process in order to prevent Netlify from seeing this as
	# a bad build.
	#
	# WARNING! Running `minify` AND Netlify's built-in optimization will
	# result in invalid HTML/CSS/JS output! Netlify optimization should
	# therefore be turned off when "hand optimization" like this is
	# used.
	#
	MINIFY_BINARY="minify-$(uname -s | tr "[:upper:]" "[:lower:]")-$(uname -m)"
	if [[ -f ../../../bin/third-party/minify/"$MINIFY_BINARY" ]]; then
		chmod +x ../../../bin/third-party/minify/"$MINIFY_BINARY"
		mv _site _site.original
		(
			cd _site.original
			../../../../bin/third-party/minify/"$MINIFY_BINARY" --all --recursive --sync --output ../_site .
		)
		rm -rf _site.original
	fi

	# Add build timestamp to the deployed site. This is useful for
	# troubleshooting.
	#
	echo "$(date -u +"%Y%m%d%H%M%S")" > _site/build-date.txt
)
