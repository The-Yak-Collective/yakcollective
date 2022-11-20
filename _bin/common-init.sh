#!/usr/bin/env bash

# Check to make sure that we're running in the repository root.
#
if [[ ! -f _config.yml || ! -d _bin ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Only run init if necessary.
#
if [[ ! -f .common-init ]]; then

	# Install pre-requisits.
	#
	[[ -z "$(which bundle)" ]] && gem install bundler

	bundle config set path vendor/bundle
	bundle install
	npm install

	# Pull Knack data.
	#
	chmod +x _bin/knack-pull-yaks.sh
	./_bin/knack-pull-yaks.sh

	# Script run indicator.
	#
	date "+%s" > .common-init
if
