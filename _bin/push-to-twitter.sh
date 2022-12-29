#!/usr/bin/env bash

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
