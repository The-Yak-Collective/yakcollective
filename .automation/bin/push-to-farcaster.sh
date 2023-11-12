#!/usr/bin/env bash

# Source init.
#
if [[ -f ./.automation/bin/common-init.sh ]]; then
	source ./.automation/bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Check to make sure that we're running in the repository root.
#
if [[ ! -d .automation/bin ]] || [[ ! -d .automation/var/spool/farcaster ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Check to make sure that the expected tokens are present in the
# environment.
#
if [[ -z "$FARCASTER_MNEMONIC" ]]; then
	echo "Missing FARCASTER_MNEMONIC environment variable!"
	exit 1
fi

# Determine the (lexigraphically) oldest Farcaster post file. This
# variable will be the empty string if no (non-hidden) files are in the
# .automation/var/spool/farcaster directory (in which case we should
# exit).
#
POST="$(ls -1 .automation/var/spool/farcaster | sort -u | head -1)"
if [[ -z "$POST" ]]; then
	exit
fi

# If $POST is a zero-length file, we just skip posting this cycle. This
# allows for (very rough) timed posting. (Basically, this forces
# automatic posting to wait an hour, though if another post is added to
# the queue with a filename that comes lexicographically before the
# zero-length "wait" post, then the wait will be bumped out one cycle.)
#
if [[ ! -s ".automation/var/spool/farcaster/$POST" ]]; then
	rm ".automation/var/spool/farcaster/$POST"
	exit
fi

# Post file contents to Farcaster and delete file if successful.
#
export FARCASTER_POST="$(cat ".automation/var/spool/farcaster/$POST")"
source .automation/var/cache/build/bin/activate
python3 -c 'import os; from farcaster import Warpcast; client = Warpcast(mnemonic = os.environ.get("FARCASTER_MNEMONIC")); client.post_cast(text = os.environ.get("FARCASTER_POST"));'
if [[ $? -eq 0 ]]; then
	rm ".automation/var/spool/farcaster/$POST"
fi
