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
if [[ ! -d _bin ]] || [[ ! -d _bluesky ]]; then
	echo "This script must be run from the repository root!"
	exit 1
fi

# Check to make sure that the expected tokens are present in the
# environment.
#
if [[ -z "$BLUESKY_APP_PASSWORD" ]]; then
	echo "Missing BLUESKY_APP_PASSWORD environment variable!"
	exit 1
fi

# Determine the (lexigraphically) oldest Bluesky post file. This
# variable will be the empty string if no (non-hidden) files are in the
# _bluesky directory
#
POST="$(ls -1 _bluesky | sort -u | head -1)"

# Post file contents to Bluesky and delete file if successful.
#
if [[ -n "$POST" ]]; then
	AUTH_TOKEN="$(curl -s -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"identifier\":\"yakcollective.org\",\"password\":\"$BLUESKY_APP_PASSWORD\"}" https://bsky.social/xrpc/com.atproto.server.createSession | jq -r .accessJwt)"
	if [[ $? -eq 0 ]]; then
		curl -s -H "Authorization: Bearer $AUTH_TOKEN" -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"repo\":\"yakcollective.org\",\"collection\":\"app.bsky.feed.post\",\"record\":{\"text\":\"$(cat "_bluesky/$POST" | sed -e 's/"/\\"/g')\",\"createdAt\":\"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\"}}" https://bsky.social/xrpc/com.atproto.repo.createRecord
		if [[ $? -eq 0 ]]; then
			rm "_bluesky/$POST"
		fi
	fi
fi
