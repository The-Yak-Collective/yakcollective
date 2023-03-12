#!/usr/bin/env bash

# Source init.
#
if [[ -f ./_bin/common-init.sh ]]; then
	source ./_bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Check to make sure that we're running in the repository root.
#
if [[ ! -d _bin ]] || [[ ! -d _twitter ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Determine the (lexigraphically) oldest Twitter post file. This
# variable will be the empty string if no (non-hidden) files are in the
# _twitter directory
#
POST="$(ls -1 _twitter | sort -u | head -1)"

# Post file contents to Twitter and archive file if successful.
#
if [[ -n "$POST" ]]; then
	export DEBUG=true
	cat "_twitter/$POST" | ./_bin/tweet.sh post
	if [[ $? -eq 0 ]]; then
		rm "_twitter/$POST"
	fi
fi
