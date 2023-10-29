#!/usr/bin/env bash

# Source init.
#
if [[ -f ./.automation/bin/common-init.sh ]]; then
	source ./.automation/bin/common-init.sh
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
if [[ -z "$NETLIFY_AUTH_TOKEN" ]]; then
	echo "Missing NETLIFY_AUTH_TOKEN environment variable!"
	exit 1
fi
          
# Push GitHub health stats to Discord.
#
GITHUB_DATA="$(curl -s -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GH_TOKEN"  https://api.github.com/orgs/${GH_ACCOUNT_SLUG}/settings/billing/actions)"

curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"**GitHub Workflow Minutes (Monthly):** $(echo $GITHUB_DATA | jq .total_minutes_used) used / $(echo $GITHUB_DATA | jq .included_minutes) available\"}" "$DISCORD_CHANNEL_URL"

# Push Netlify health stats to Discord.
#
NETLIFY_DATA="$(curl -s -H "User-Agent: MyApp $NETLIFY_ACCOUNT_EMAIL" -H "Authorization: Bearer $NETLIFY_AUTH_TOKEN" https://api.netlify.com/api/v1/${NETLIFY_ACCOUNT_SLUG}/builds/status)"

curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"**Netlify Build Minutes (Monthly):** $(echo $NETLIFY_DATA | jq .minutes.current) used / $(echo $NETLIFY_DATA | jq .minutes.included_minutes) available\"}" "$DISCORD_CHANNEL_URL"
