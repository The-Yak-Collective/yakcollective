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
if [[ ! -d _bin ]] || [[ ! -d _discord ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Check to make sure that the expected tokens are present in the
# environment.
#
if [[ -z "$DISCORD_CHANNEL_URL" ]]; then
	echo "Missing DISCORD_CHANNEL_URL environment variable!"
	exit 1
fi

# Determine the (lexigraphically) oldest Discord post file. This
# variable will be the empty string if no (non-hidden) files are in the
# _discord directory
#
POST="$(ls -1 _discord | sort -u | head -1)"

# Post file contents to Discord and delete file if successful.
#
if [[ -n "$POST" ]]; then
	curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"$(cat "_discord/$POST" | sed -e 's/"/\\"/g')\"}" "$DISCORD_CHANNEL_URL"
	if [[ $? -eq 0 ]]; then
		rm "_discord/$POST"
	fi
fi
