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

# Check to make sure that the expected tokens are present in the
# environment.
#
if [[ -z "$IFTTT_MAKER_KEY" ]]; then
	echo "Missing IFTTT_MAKER_KEY environment variable!"
	exit 1
fi

# Determine the (lexigraphically) oldest Twitter post file. This
# variable will be the empty string if no (non-hidden) files are in the
# _twitter directory
#
POST="$(ls -1 _twitter | sort -u | head -1)"

# Post file contents to Twitter and delete file if successful.
#
if [[ -n "$POST" ]]; then
	curl -s -G --data-urlencode "value1=$(cat "_twitter/$POST" | sed -e 's/"/\\"/g')" https://maker.ifttt.com/trigger/post_to_twitter/with/key/$IFTTT_MAKER_KEY
	if [[ $? -eq 0 ]]; then
		rm "_twitter/$POST"
	fi
fi
