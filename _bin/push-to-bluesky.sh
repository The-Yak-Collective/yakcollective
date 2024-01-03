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
# _bluesky directory (in which case we should exit).
#
POST="$(ls -1 _bluesky | sort -u | head -1)"
if [[ -z "$POST" ]]; then
	exit
fi

# If $POST is a zero-length file, we just skip posting this cycle. This
# allows for (very rough) timed posting. (Basically, this forces
# automatic posting to wait an hour, though if another post is added to
# the queue with a filename that comes lexicographically before the
# zero-length "wait" post, then the wait will be bumped out one cycle.)
#
if [[ ! -s "_bluesky/$POST" ]]; then
	rm "_bluesky/$POST"
	exit
fi

# Posting to Bluesky with working links takes a lot of magic. It's
# helpful to have the post content stored as a variable for what's
# about to come.
#
POST_CONTENT="$(cat "_bluesky/$POST")"

# Bluesky posts can contain unicode, which CAN use multibyte
# characters. And the "facet" functionality counts things in BYTES, not
# characters! To PARTIALLY work around this, we temporarilly set LANG
# and LC_ALL to the generic "C" locale. See:
#
# https://stackoverflow.com/questions/17368067/length-of-string-in-bash/31009961#31009961
#
# FIXME: The right solution here is probably to rewrite this script in
# something like Python and directly lift the example code from the
# Bluesky blog.
#
ORIGINAL_LANG=$LANG
ORIGINAL_LC_ALL=$LC_ALL

export LANG=C
export LC_ALL=C

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

if [[ "$MENTION_DID" = "null" ]] || [[ -z "$MENTION_DID" ]]; then
	MENTION_FACET=""
else
	MENTION_FACET=",{\"index\":{\"byteStart\":$MENTION_START,\"byteEnd\":$MENTION_END},\"features\":[{\"\$type\":\"app.bsky.richtext.facet#mention\",\"did\":\"$MENTION_DID\"}]}"
fi

# Reset LANG and LC_ALL back to the system default to avoid any
# weirdness with the curl command line below.
#
export LANG=$ORIGINAL_LANG
export LC_ALL=$ORIGINAL_LC_ALL

# Post file contents to Bluesky and delete file if successful.
#
AUTH_TOKEN="$(curl -s -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"identifier\":\"yakcollective.org\",\"password\":\"$BLUESKY_APP_PASSWORD\"}" https://bsky.social/xrpc/com.atproto.server.createSession | jq -r .accessJwt)"
if [[ $? -eq 0 ]]; then
	curl -s -H "Authorization: Bearer $AUTH_TOKEN" -H "Accept: application/json" -H "Content-Type: application/json" -d "{\"repo\":\"yakcollective.org\",\"collection\":\"app.bsky.feed.post\",\"record\":{\"\$type\":\"app.bsky.feed.post\",\"text\":\"$(echo "$POST_CONTENT" | sed -e 's/"/\\"/g')\",\"createdAt\":\"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\",\"facets\":[$LINK_FACET$MENTION_FACET]}}" https://bsky.social/xrpc/com.atproto.repo.createRecord

	rm "_bluesky/$POST"
fi
