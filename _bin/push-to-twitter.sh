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
# _twitter directory (in which case we should exit).
#
POST="$(ls -1 _twitter | sort -u | head -1)"
if [[ -z "$POST" ]]; then
	exit
fi

# If $POST is a zero-length file, we just skip posting this cycle. This
# allows for (very rough) timed posting. (Basically, this forces
# automatic posting to wait an hour, though if another post is added to
# the queue with a filename that comes lexicographically before the
# zero-length "wait" post, then the wait will be bumped out one cycle.)
#
if [[ ! -s "_twitter/$POST" ]]; then
	rm "_twitter/$POST"
	exit
fi

# Post file contents to Twitter and delete file if successful.
#
curl -s -G --data-urlencode "value1=$(cat "_twitter/$POST" | sed -e 's/"/\\"/g')" https://maker.ifttt.com/trigger/post_to_twitter/with/key/$IFTTT_MAKER_KEY

rm "_twitter/$POST"
