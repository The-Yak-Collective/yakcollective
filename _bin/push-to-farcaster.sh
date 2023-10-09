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
if [[ ! -d _bin ]] || [[ ! -d _farcaster ]]; then
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
# _farcaster directory
#
POST="$(ls -1 _farcaster | sort -u | head -1)"

# Post file contents to Farcaster and delete file if successful.
#
if [[ -n "$POST" ]]; then
	export FARCASTER_POST="$(cat "_farcaster/$POST")"
	python3 -c 'import os; from farcaster import Warpcast; client = Warpcast(mnemonic = os.environ.get("FARCASTER_MNEMONIC")); client.post_cast(text = os.environ.get("FARCASTER_POST"));'
	if [[ $? -eq 0 ]]; then
		rm "_farcaster/$POST"
	fi
fi
