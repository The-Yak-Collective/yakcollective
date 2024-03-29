# Yak Collective Website

![Netlify Status](https://api.netlify.com/api/v1/badges/943ff646-41b6-4b4b-ab86-a891698c72c7/deploy-status)

Every collective needs a website. This is ours. It isn't much to look at, but it gets the job done.

## Local Website and Automation Testing

```bash
# Make sure that the environment is set.
#
export KNACK_APP_ID=XXXXXXXXXXXXXXX
export KNACK_API_KEY=XXXXXXXXXXXXXXX
export KNACK_OBJECT=XXXXXXXXXXXXXXX
[[ ! -f pyvenv.cfg ]] && python3 -m venv .
. ./bin/activate
[[ -f .common-init ]] && rm .common-init
./_bin/common-init.sh

# Pull RSS feed update.
#
./_bin/rss-pull-feeds.sh

# Build the actual website.
#
./_bin/build.sh

# View the website locally via http://127.0.0.1:4000.
#
bundle exec jekyll serve

# Push the website to Netlify.
#
export NETLIFY_AUTH_TOKEN=XXXXXXXXXXXXXXX
export NETLIFY_SITE=XXXXXXXXXXXXXXX
./node_modules/.bin/netlify deploy --dir _site --site $NETLIFY_SITE --message "Local development deploy $(date -u +"%Y%m%d%H%M%S")/${USER}@${HOST}" --prod

# Push an update to Twitter.
#
export IFTTT_MAKER_KEY=XXXXXXXXXXXXXXX
./_bin/push-to-twitter.sh

# Push an update to Bluesky.
#
export BLUESKY_APP_PASSWORD=XXXXXXXXXXXXXXX
./_bin/push-to-bluesky.sh

# Push an update to Farcaster.
#
export FARCASTER_MNEMONIC="XXXXXXXXXXXXXXX"
./_bin/push-to-farcaster.sh

# Run the #yaks-at-work update script.
#
export DISCORD_CHANNEL_URL=https://discord.com/api/webhooks/0000000000000000/XXXXXXXXXXXXXXX
./_bin/push-to-discord.sh

# Push website health stats to Discord.
#
export DISCORD_CHANNEL_URL=https://discord.com/api/webhooks/0000000000000000/XXXXXXXXXXXXXXX
export GH_ACCOUNT_SLUG=XXXXXXXXXXXXXXX
export GH_TOKEN=XXXXXXXXXXXXXXX
export NETLIFY_ACCOUNT_EMAIL=XXXXXXXXXXXXXXX@XXXXXXXXXXXXXXX
export NETLIFY_ACCOUNT_SLUG=XXXXXXXXXXXXXXX
export NETLIFY_AUTH_TOKEN=XXXXXXXXXXXXXXX
./_bin/stats-to-discord.sh

# Leave Python virtual environment.
#
deactivate
```

## Ways to Contribute

[Current website issues and projects on GitHub.](https://github.com/The-Yak-Collective/yakcollective/issues) Pull requests and ideas welcome!

Conversations happen on [the Discord #infrastructure channel](https://discord.com/channels/692111190851059762/704369362315772044).
