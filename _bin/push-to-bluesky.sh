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
POST_CONTENT="$(cat "_bluesky/$POST")"

# Pull out link (if any). Regex from:
#
#     https://atproto.com/blog/create-post#mentions-and-links
#
# Math from:
#
#     https://superuser.com/questions/1001973/bash-find-string-index-position-of-substring/1001979#1001979
#
# NOTE: This implicitly assumes that there is EXACTLYT ONE link in a
# post!
#
LINK="$(echo "$POST_CONTENT" | sed 's/.*\W\?\(https\?:\/\/\(www\.\)\?[-a-zA-Z0-9@:%._+~#=]\{1,256\}\.[a-zA-Z0-9()]\{1,6\}\b\([-a-zA-Z0-9()@:%_+.~#?&/=]*[-a-zA-Z0-9@%_+~#/=]\)\?\)\W\?.*/\1/')"

REMAINING="${POST_CONTENT#*$LINK}"
LINK_START=$(( ${#POST_CONTENT} - ${#REMAINING} - ${#LINK} ))
LINK_END=$(( ${#POST_CONTENT} - ${#REMAINING} ))

LINK_FACET="{\"index\":{\"byteStart\":$LINK_START,\"byteEnd\":$LINK_END},\"features\":[{\"\$type\":\"app.bsky.richtext.facet#link\",\"uri\":\"$LINK\"}]}"

# Pull out and resolve mention (if any). Regex from:
#
#     https://atproto.com/blog/create-post#mentions-and-links
#
# Math from:
#
#     https://superuser.com/questions/1001973/bash-find-string-index-position-of-substring/1001979#1001979
#
# NOTE: This implicitly assumes that there is EXACTLY ONE mention in a
# post!
#
MENTION="$(echo "$POST_CONTENT" | sed 's/.*\W\?\(@\([a-zA-Z0-9]\([a-zA-Z0-9-]\{0,61\}[a-zA-Z0-9]\)\?\.\)\+[a-zA-Z]\([a-zA-Z0-9-]\{0,61\}[a-zA-Z0-9]\)\?\)\W\?.*/\1/')"

REMAINING="${POST_CONTENT#*$MENTION}"
MENTION_START=$(( ${#POST_CONTENT} - ${#REMAINING} - ${#MENTION} ))
MENTION_END=$(( ${#POST_CONTENT} - ${#REMAINING} ))

MENTION_DID="$(curl -s "https://bsky.social/xrpc/com.atproto.identity.resolveHandle?handle=${MENTION:1}" | jq -r .did)"

if [[ "$MENTION_DID" = "null" ]]; then
	MENTION_FACET=""
else
	MENTION_FACET=",{\"index\":{\"byteStart\":$MENTION_START,\"byteEnd\":$MENTION_END},\"features\":[{\"\$type\":\"app.bsky.richtext.facet#mention\",\"did\":\"$MENTION_DID\"}]}"
fi

# Post file contents to Bluesky and delete file if successful.
#
if [[ -n "$POST" ]]; then
	AUTH_TOKEN="$(curl -s -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"identifier\":\"yakcollective.org\",\"password\":\"$BLUESKY_APP_PASSWORD\"}" https://bsky.social/xrpc/com.atproto.server.createSession | jq -r .accessJwt)"
	if [[ $? -eq 0 ]]; then
		curl -s -H "Authorization: Bearer $AUTH_TOKEN" -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"repo\":\"yakcollective.org\",\"collection\":\"app.bsky.feed.post\",\"record\":{\"\$type\":\"app.bsky.feed.post\",\"text\":\"$(echo "$POST_CONTENT" | sed -e 's/"/\\"/g')\",\"createdAt\":\"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\",\"facets\":[$LINK_FACET$MENTION_FACET]}}" https://bsky.social/xrpc/com.atproto.repo.createRecord
		if [[ $? -eq 0 ]]; then
			rm "_bluesky/$POST"
		fi
	fi
fi
