#!/usr/bin/env bash

# Source init.
#
if [[ -f ./_bin/common-init.sh ]]; then
	source ./_bin/common-init.sh
else
	echo "Init file not found! Are you running from the repository root?"
	exit 1
fi

# Make sure that environment is sane.
#
if [[ -z "$DISCORD_CHANNEL_URL" ]]; then
	echo "Missing DISCORD_CHANNEL_URL environment variable!"
	exit 1
fi
if [[ -z "$GH_ACCOUNT_SLUG" ]]; then
	echo "Missing GH_ACCOUNT_SLUG environment variable!"
	exit 1
fi
if [[ -z "$GH_TOKEN" ]]; then
	echo "Missing GH_TOKEN environment variable!"
	exit 1
fi
if [[ -z "$NETLIFY_ACCOUNT_EMAIL" ]]; then
	echo "Missing NETLIFY_ACCOUNT_EMAIL environment variable!"
	exit 1
fi
if [[ -z "$NETLIFY_ACCOUNT_SLUG" ]]; then
	echo "Missing NETLIFY_ACCOUNT_SLUG environment variable!"
	exit 1
fi
if [[ -z "$NETLIFY_TOKEN" ]]; then
	echo "Missing NETLIFY_TOKEN environment variable!"
	exit 1
fi
          
# Push GitHub health stats to Discord.
#
GITHUB_DATA="$(curl -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_ACCESS_TOKEN"  https://api.github.com/orgs/${GH_ACCOUNT_SLUG}/settings/billing/actions)"

curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"GitHub Workflow Minutes: $(echo $GITHUB_DATA | jq .total_minutes_used) / $(echo $GITHUB_DATA | jq .included_minutes)\"}" "$DISCORD_CHANNEL_URL"

# Push Netlify health stats to Discord.
#
NETLIFY_DATA="$(curl -H "User-Agent: MyApp $NETLIFY_ACCOUNT_EMAIL" -H "Authorization: Bearer $NETLIFY_TOKEN" https://api.netlify.com/api/v1/${NETLIFY_ACCOUNT_SLUG}/builds/status)"

curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"Netlify Build Minutes: $(echo $NETLIFY_DATA | jq .minutes.current) / $(echo $NETLIFY_DATA | jq .minutes.included_minutes)\"}" "$DISCORD_CHANNEL_URL"
