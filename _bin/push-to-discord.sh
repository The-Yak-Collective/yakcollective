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
# _discord directory (in which case we should exit).
#
POST="$(ls -1 _discord | sort -u | head -1)"
if [[ -z "$POST" ]]; then
	exit
fi

# If $POST is a zero-length file, we just skip posting this cycle. This
# allows for (very rough) timed posting. (Basically, this forces
# automatic posting to wait an hour, though if another post is added to
# the queue with a filename that comes lexicographically before the
# zero-length "wait" post, then the wait will be bumped out one cycle.)
#
if [[ ! -s "_discord/$POST" ]]; then
	rm "_discord/$POST"
	exit
fi

# Post file contents to Discord and delete file if successful.
#
curl -s -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"content\":\"$(cat "_discord/$POST" | sed -e 's/"/\\"/g')\"}" "$DISCORD_CHANNEL_URL"
if [[ $? -eq 0 ]]; then
	rm "_discord/$POST"
fi
